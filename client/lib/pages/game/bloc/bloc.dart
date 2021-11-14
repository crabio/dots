import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dots_client/pages/game/resources/player_state.dart';
import '../resources/session_winner.dart';
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

  late ResponseFuture<proto.SendPlayerPositionResponse> _geoPositionStream;
  late StreamSubscription<proto.GetPlayersStatesResponse> _playersStatesStream;

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
    on<SessionStopEvent>(_onSessionStopEvent);
    on<ZoneTickEvent>(_onZoneTickEvent);
    on<LeaveSpotEvent>(_onLeaveSpotEvent);

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
    var ex = _subscribeOnPlayersStates();
    if (ex != null) {
      emit(ErrorState(exception: ex));
    }

    _logger.fine("Get last session event");
    ex = await _getLastGameEvent();
    if (ex != null) {
      emit(ErrorState(exception: ex));
    }

    _logger.fine("Subscribe on session events");
    ex = _subscribeOnSpotSessionEvents();
    if (ex != null) {
      emit(ErrorState(exception: ex));
    }

    _logger.fine("Get last zone event");
    ex = await _getLastZoneEvent();
    if (ex != null) {
      emit(ErrorState(exception: ex));
    }

    _logger.fine("Subscribe on zone state");
    ex = _subscribeOnZoneEvents();
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
      _geoPositionStream = client
          .sendPlayerPosition(_createPlayerPositionStream(positionStream));
      _geoPositionStream.onError((error, stackTrace) {
        _logger.shout("sendPlayerPosition error: $error");
        return proto.SendPlayerPositionResponse();
      });
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

  Exception? _subscribeOnPlayersStates() {
    try {
      final request = proto.GetPlayersStatesRequest(
        spotUuid: spotUuid,
        playerUuid: playerUuid,
      );
      _playersStatesStream = client.getPlayersStates(request).listen(
            (value) => add(
              NewPlayersStatesEvent(
                playerUuid: value.playerState.playerUuid,
                playerPosition: LatLng(
                  value.playerState.position.latitude,
                  value.playerState.position.longitude,
                ),
                playerHealth: value.playerState.health,
              ),
            ),
            onError: (error) => _logger.shout("getPlayersStates error: $error"),
          );
    } on Exception catch (ex) {
      return ex;
    }
  }

  Exception? _subscribeOnZoneEvents() {
    try {
      final request = proto.SubZoneEventRequest(spotUuid: spotUuid);

      client.subZoneEvent(request).listen(
        (value) {
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
        },
        onError: (error) => _logger.shout("subZoneEvent error: $error"),
      );
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
          // No last event
          return null;
      }
    } on Exception catch (ex) {
      return ex;
    }
  }

  Exception? _subscribeOnSpotSessionEvents() {
    try {
      client
          .subGameEvent(proto.SubGameEventRequest(
        spotUuid: spotUuid,
      ))
          .listen(
        (value) {
          switch (value.whichEvent()) {
            case proto.SubGameEventResponse_Event.startGameEvent:
              _logger.fine("Session was started");
              break;
            case proto.SubGameEventResponse_Event.stopGameEvent:
              _logger.fine("Session was stopped");
              _processStopGameEvent(value.stopGameEvent);
              break;
            default:
              throw Exception("Unimplemented");
          }
        },
        onError: (error) => _logger.shout("subGameEvent error: $error"),
      );
    } on Exception catch (ex) {
      return ex;
    }
  }

  Future<Exception?> _getLastGameEvent() async {
    try {
      final response = await client.getLastGameEvent(
        proto.GetLastGameEventRequest(spotUuid: spotUuid),
      );
      switch (response.whichEvent()) {
        case proto.GetLastGameEventResponse_Event.startGameEvent:
          _logger.fine("Session was started");
          break;
        case proto.GetLastGameEventResponse_Event.stopGameEvent:
          _logger.fine("Session was stopped");
          _processStopGameEvent(response.stopGameEvent);
          break;
        default:
          // No last event
          return null;
      }
    } on Exception catch (ex) {
      return ex;
    }
  }

  void _processStopGameEvent(proto.StopGameEvent event) {
    _logger.fine("Session was stopped");
    switch (event.winner) {
      case proto.StopGameEvent_GameWinner.GAME_WINNER_HUNTER:
        add(const SessionStopEvent(winner: GameWinnerEnum.hunter));
        break;

      case proto.StopGameEvent_GameWinner.GAME_WINNER_VICTIMS:
        add(const SessionStopEvent(winner: GameWinnerEnum.victims));
        break;

      case proto.StopGameEvent_GameWinner.GAME_WINNER_DRAW:
        add(const SessionStopEvent(winner: GameWinnerEnum.draw));
        break;

      default:
        throw Exception("unimplemented");
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

  void _onSessionStopEvent(
    SessionStopEvent event,
    Emitter<GamePageState> emit,
  ) async {
    await _geoPositionStream.cancel();
    _logger.fine("Geo position stream stopped");
    await _playersStatesStream.cancel();
    _logger.fine("Players state stream stopped");

    switch (event.winner) {
      case GameWinnerEnum.hunter:
        emit(HunterWinsState());
        break;

      case GameWinnerEnum.victims:
        emit(VictimsWinsState());
        break;

      case GameWinnerEnum.draw:
        emit(DrawState());
        break;

      default:
        throw Exception("Unimplemented");
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

  Future<void> _onLeaveSpotEvent(
    LeaveSpotEvent event,
    Emitter<GamePageState> emit,
  ) async {
    await client
        .leaveSpot(proto.LeaveSpotRequest(
          spotUuid: spotUuid,
          playerUuid: playerUuid,
        ))
        .then(
          (response) => emit(const LeavingSpotState()),
          onError: (error) => emit(ErrorState(exception: error)),
        );
  }
}
