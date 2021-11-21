import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dots_client/pages/game/resources/player_state.dart';
import '../resources/session_winner.dart';
import 'package:dots_client/pages/game/resources/zone_state.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
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

  late StreamController<Position> _geoPositionStream;
  late StreamSubscription<proto.GetPlayersStatesResponse> _playersStatesStream;

  GamePageBloc({
    required this.client,
    required this.geolocator,
    required this.spotUuid,
    required this.playerUuid,
  }) : super(const GamePageInitial()) {
    on<InitEvent>(_onInitEvent);
    on<NewPlayersStatesEvent>(_onNewPlayersStatesEvent);
    on<StartNextZoneTimerEvent>(_onStartNextZoneTimerEvent);
    on<StartZoneDelayTimerEvent>(_onStartZoneDelayTimerEvent);
    on<SessionStopEvent>(_onSessionStopEvent);
    on<ZoneTickEvent>(_onZoneTickEvent);
    on<LeaveSpotEvent>(_onLeaveSpotEvent);

    add(const InitEvent());
  }

  void _onInitEvent(InitEvent event, Emitter<GamePageState> emit) async {
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
    await _subOnGeoPosition(emit);

    _logger.fine("Subscribe on players states");
    await _subOnPlayersStates(emit);

    _logger.fine("Subscribe on session events");
    _subOnSessionEvents(emit);

    _logger.fine("Subscribe on zone state");
    _subscribeOnZoneEvents(emit);
  }

  Future<void> _subOnGeoPosition(Emitter<GamePageState> emit) async {
    _geoPositionStream = StreamController<Position>(
        onListen: () => geolocator
            .getPositionStream(desiredAccuracy: LocationAccuracy.high)
            .listen((event) => event));

    await client
        .sendPlayerPosition(_createPlayerPositionStream(
          _geoPositionStream.stream,
        ))
        .then(
          (response) => null,
          onError: (error) => emit(ErrorState(exception: error)),
        );
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

  Future<void> _subOnPlayersStates(Emitter<GamePageState> emit) async {
    _playersStatesStream = client
        .getPlayersStates(proto.GetPlayersStatesRequest(
          spotUuid: spotUuid,
          playerUuid: playerUuid,
        ))
        .listen(
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
          onError: (error) => emit(ErrorState(exception: error)),
        );
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

  void _subOnSessionEvents(Emitter<GamePageState> emit) {
    client.subGameEvent(proto.SubGameEventRequest(spotUuid: spotUuid)).listen(
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
      onError: (error) => emit(ErrorState(exception: error)),
    );
  }

  void _subscribeOnZoneEvents(Emitter<GamePageState> emit) {
    client.subZoneEvent(proto.SubZoneEventRequest(spotUuid: spotUuid)).listen(
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
      onError: (error) => emit(ErrorState(exception: error)),
    );
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
    await _geoPositionStream.close();
    _logger.fine("Geo position stream stopped");
    await _playersStatesStream.cancel();
    _logger.fine("Players state stream stopped");

    switch (event.winner) {
      case GameWinnerEnum.hunter:
        emit(const HunterWinsState());
        break;

      case GameWinnerEnum.victims:
        emit(const VictimsWinsState());
        break;

      case GameWinnerEnum.draw:
        emit(const DrawState());
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
      onError: (error) async {
        emit(ErrorState(exception: error));
        // Go to main page after time
        await Future.delayed(
          const Duration(seconds: 10),
          () => emit(const LeavingSpotState()),
        );
      },
    );
  }
}
