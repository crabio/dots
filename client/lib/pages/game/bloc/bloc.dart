import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dots_client/pages/game/resources/player_position.dart';
import 'package:dots_client/pages/game/resources/zone_state.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
part 'event.dart';
part 'state.dart';
part 'bloc.g.dart';

class GamePageBloc extends Bloc<GamePageEvent, GamePageState> {
  final proto.SpotServiceClient client;
  final GeolocatorPlatform geolocator;
  final String spotUuid;
  final String playerUuid;

  final _logger = Logger("SpotPageBloc");

  GamePageBloc({
    required this.client,
    required this.geolocator,
    required this.spotUuid,
    required this.playerUuid,
  }) : super(GamePageInitial()) {
    on<InitEvent>(_onInitEvent);
    on<NewPlayersStatesEvent>(_onNewPlayersStatesEvent);
    on<StartNextZoneTimerEvent>(_onStartNextZoneTimerEvent);
    on<StartZoneDelayTimerEvent>(_onStartZoneDelayTimerEvent);
    on<ZoneTickEvent>(_onZoneTickEvent);

    add(InitEvent());
  }

  void _onInitEvent(InitEvent event, Emitter<GamePageState> emit) async {
    _logger.fine("Get spot data");
    final spotData = await _getSpotData().then((value) => value.fold(
          (l) {
            emit(ErrorState(exception: l));
            return null;
          },
          (r) => r,
        ));
    if (spotData == null) {
      return;
    }

    _logger.fine("Get last player known geo position");
    final lastKnownPlayerPos = await geolocator.getLastKnownPosition();
    if (lastKnownPlayerPos == null) {
      emit(ErrorState(
          exception: Exception("Couldn't get last known player pos")));
    }
    emit(InitedState(
      playerState: PlayerState(
        position: LatLng(
          lastKnownPlayerPos!.latitude,
          lastKnownPlayerPos.longitude,
        ),
        health: 100,
      ),
      otherPlayersStates: const {},
    ));

    _logger.fine("Subscribe on geo position");
    _subscribeOnGeoPosition().fold(
      (l) => emit(ErrorState(exception: l)),
      (r) => null,
    );

    _logger.fine("Subscribe on players states");
    _subscribeOnPlayersStates().fold(
      (l) => emit(ErrorState(exception: l)),
      (r) => r.listen((value) => add(NewPlayersStatesEvent(
            playerUuid: value.playerState.playerUuid,
            playerPosition: LatLng(
              value.playerState.position.latitude,
              value.playerState.position.longitude,
            ),
            playerHealth: value.playerState.health,
          ))),
    );

    _logger.fine("Subscribe on zone state");
    var ex = _subscribeOnZoneEvents();
    if (ex != null) {
      emit(ErrorState(exception: ex));
    }

    _logger.fine("Get last zone event");
    ex = await _getLastZoneEvent();
    if (ex != null) {
      emit(ErrorState(exception: ex));
    }
  }

  Future<Either<Exception, proto.GetSpotResponse>> _getSpotData() async {
    final request = proto.GetSpotRequest(spotUuid: spotUuid);
    try {
      return Right(await client.getSpot(request));
    } on Exception catch (ex) {
      return Left(ex);
    }
  }

  Either<Exception, bool> _subscribeOnGeoPosition() {
    final positionStream = geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      client.sendPlayerPosition(_createPlayerPositionStream(positionStream));
    } on Exception catch (ex) {
      return Left(ex);
    }

    return const Right(true);
  }

  Stream<proto.SendPlayerPositionRequest> _createPlayerPositionStream(
      Stream<Position> stream) async* {
    await for (final position in stream) {
      yield proto.SendPlayerPositionRequest(
        spotUuid: spotUuid,
        playerUuid: playerUuid,
        position: proto.Position(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    }
  }

  Either<Exception, ResponseStream<proto.GetPlayersStatesResponse>>
      _subscribeOnPlayersStates() {
    try {
      final request = proto.GetPlayersStatesRequest(
        spotUuid: spotUuid,
        playerUuid: playerUuid,
      );

      return Right(client.getPlayersStates(request));
    } on Exception catch (ex) {
      return Left(ex);
    }
  }

  Exception? _subscribeOnZoneEvents() {
    try {
      final request = proto.SubZoneEventRequest(spotUuid: spotUuid);

      client.subZoneEvent(request).listen((value) {
        switch (value.whichEvent()) {
          case proto.SubZoneEventResponse_Event.startNextZoneTimerEvent:
            final event = value.startNextZoneTimerEvent;
            add(StartNextZoneTimerEvent(
              currentZone: ZoneState(
                position: LatLng(
                  event.currentZone.position.latitude,
                  event.currentZone.position.longitude,
                ),
                radiusInM: event.currentZone.radiusInM,
                damage: event.currentZone.damage,
              ),
              nextZoneTime: DateTime.fromMillisecondsSinceEpoch(
                  event.nextZoneTimestamp.toInt() * 1000),
            ));
            break;

          case proto.SubZoneEventResponse_Event.startZoneDelayTimerEvent:
            final event = value.startZoneDelayTimerEvent;
            add(StartZoneDelayTimerEvent(
              currentZone: ZoneState(
                position: LatLng(
                  event.currentZone.position.latitude,
                  event.currentZone.position.longitude,
                ),
                radiusInM: event.currentZone.radiusInM,
                damage: event.currentZone.damage,
              ),
              nextZone: ZoneState(
                position: LatLng(
                  event.nextZone.position.latitude,
                  event.nextZone.position.longitude,
                ),
                radiusInM: event.nextZone.radiusInM,
                damage: event.nextZone.damage,
              ),
              zoneTickStartTimestamp: DateTime.fromMillisecondsSinceEpoch(
                  event.zoneTickStartTimestamp.toInt() * 1000),
            ));
            break;

          case proto.SubZoneEventResponse_Event.zoneTickEvent:
            final event = value.zoneTickEvent;
            add(ZoneTickEvent(
              currentZone: ZoneState(
                position: LatLng(
                  event.currentZone.position.latitude,
                  event.currentZone.position.longitude,
                ),
                radiusInM: event.currentZone.radiusInM,
                damage: event.currentZone.damage,
              ),
              nextZone: ZoneState(
                position: LatLng(
                  event.nextZone.position.latitude,
                  event.nextZone.position.longitude,
                ),
                radiusInM: event.nextZone.radiusInM,
                damage: event.nextZone.damage,
              ),
            ));
            break;

          default:
            throw Exception("Unimplemented");
        }
      });
      return null;
    } on Exception catch (ex) {
      return ex;
    }
  }

  Future<Exception?> _getLastZoneEvent() async {
    try {
      final response = await client
          .getLastZoneEvent(proto.GetLastZoneEventRequest(spotUuid: spotUuid));

      switch (response.whichEvent()) {
        case proto.GetLastZoneEventResponse_Event.startNextZoneTimerEvent:
          final event = response.startNextZoneTimerEvent;
          add(StartNextZoneTimerEvent(
            currentZone: ZoneState(
              position: LatLng(
                event.currentZone.position.latitude,
                event.currentZone.position.longitude,
              ),
              radiusInM: event.currentZone.radiusInM,
              damage: event.currentZone.damage,
            ),
            nextZoneTime: DateTime.fromMillisecondsSinceEpoch(
                event.nextZoneTimestamp.toInt() * 1000),
          ));
          break;

        case proto.GetLastZoneEventResponse_Event.startZoneDelayTimerEvent:
          final event = response.startZoneDelayTimerEvent;
          add(StartZoneDelayTimerEvent(
            currentZone: ZoneState(
              position: LatLng(
                event.currentZone.position.latitude,
                event.currentZone.position.longitude,
              ),
              radiusInM: event.currentZone.radiusInM,
              damage: event.currentZone.damage,
            ),
            nextZone: ZoneState(
              position: LatLng(
                event.nextZone.position.latitude,
                event.nextZone.position.longitude,
              ),
              radiusInM: event.nextZone.radiusInM,
              damage: event.nextZone.damage,
            ),
            zoneTickStartTimestamp: DateTime.fromMillisecondsSinceEpoch(
                event.zoneTickStartTimestamp.toInt() * 1000),
          ));
          break;

        case proto.GetLastZoneEventResponse_Event.zoneTickEvent:
          final event = response.zoneTickEvent;
          add(ZoneTickEvent(
            currentZone: ZoneState(
              position: LatLng(
                event.currentZone.position.latitude,
                event.currentZone.position.longitude,
              ),
              radiusInM: event.currentZone.radiusInM,
              damage: event.currentZone.damage,
            ),
            nextZone: ZoneState(
              position: LatLng(
                event.nextZone.position.latitude,
                event.nextZone.position.longitude,
              ),
              radiusInM: event.nextZone.radiusInM,
              damage: event.nextZone.damage,
            ),
          ));
          break;

        default:
          throw Exception("Unimplemented");
      }

      return null;
    } on Exception catch (ex) {
      return ex;
    }
  }

  void _onNewPlayersStatesEvent(
    NewPlayersStatesEvent event,
    Emitter<GamePageState> emit,
  ) async {
    final curState = state;
    if (curState is InitedState) {
      if (event.playerUuid == playerUuid) {
        // Update this player state
        emit(curState.copyWith(
          playerState: PlayerState(
            position: event.playerPosition,
            health: event.playerHealth,
          ),
        ));
      } else {
        // Update another player state
        final otherPlayersStates = Map.of(curState.otherPlayersStates);
        otherPlayersStates[event.playerUuid] = PlayerState(
          position: event.playerPosition,
          health: event.playerHealth,
        );
        emit(curState.copyWith(otherPlayersStates: otherPlayersStates));
      }
    } else {
      _logger.shout("Wrong state $curState for $event");
    }
  }

  void _onStartNextZoneTimerEvent(
    StartNextZoneTimerEvent event,
    Emitter<GamePageState> emit,
  ) async {
    final curState = state;
    if (curState is InitedState) {
      emit(InitedState(
        playerState: curState.playerState,
        otherPlayersStates: curState.otherPlayersStates,
        currentZone: event.currentZone,
        nextZone: null,
        nextZoneTime: event.nextZoneTime,
        zoneTickStartTimestamp: null,
      ));
    } else {
      _logger.shout("Wrong state $curState for $event");
    }
  }

  void _onStartZoneDelayTimerEvent(
    StartZoneDelayTimerEvent event,
    Emitter<GamePageState> emit,
  ) async {
    final curState = state;
    if (curState is InitedState) {
      emit(InitedState(
        playerState: curState.playerState,
        otherPlayersStates: curState.otherPlayersStates,
        currentZone: event.currentZone,
        nextZone: event.nextZone,
        nextZoneTime: null,
        zoneTickStartTimestamp: event.zoneTickStartTimestamp,
      ));
    } else {
      _logger.shout("Wrong state $curState for $event");
    }
  }

  void _onZoneTickEvent(
    ZoneTickEvent event,
    Emitter<GamePageState> emit,
  ) async {
    final curState = state;
    if (curState is InitedState) {
      emit(InitedState(
        playerState: curState.playerState,
        otherPlayersStates: curState.otherPlayersStates,
        currentZone: event.currentZone,
        nextZone: event.nextZone,
        nextZoneTime: null,
        zoneTickStartTimestamp: null,
      ));
    } else {
      _logger.shout("Wrong state $curState for $event");
    }
  }
}
