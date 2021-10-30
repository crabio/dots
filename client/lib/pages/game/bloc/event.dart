part of 'bloc.dart';

@immutable
abstract class GamePageEvent extends Equatable {
  const GamePageEvent();

  @override
  List<Object> get props => [];
}

/// Event for initing all required components
class InitEvent extends GamePageEvent {}

/// New players states event
class NewPlayersStatesEvent extends GamePageEvent {
  final String playerUuid;
  final LatLng playerPosition;
  final double playerHealth;

  const NewPlayersStatesEvent({
    required this.playerUuid,
    required this.playerHealth,
    required this.playerPosition,
  });

  @override
  List<Object> get props => [
        playerUuid,
        playerPosition,
        playerHealth,
      ];
}

class StartNextZoneTimerEvent extends GamePageEvent {
  final ZoneState currentZone;
  final DateTime nextZoneTime;

  const StartNextZoneTimerEvent({
    required this.currentZone,
    required this.nextZoneTime,
  });

  @override
  List<Object> get props => [
        currentZone,
        nextZoneTime,
      ];
}

class StartZoneDelayTimerEvent extends GamePageEvent {
  final ZoneState currentZone;
  final ZoneState nextZone;
  final DateTime zoneTickStartTimestamp;

  const StartZoneDelayTimerEvent({
    required this.currentZone,
    required this.nextZone,
    required this.zoneTickStartTimestamp,
  });

  @override
  List<Object> get props => [
        currentZone,
        nextZone,
        zoneTickStartTimestamp,
      ];
}

class ZoneTickEvent extends GamePageEvent {
  final ZoneState currentZone;
  final ZoneState nextZone;

  const ZoneTickEvent({
    required this.currentZone,
    required this.nextZone,
  });

  @override
  List<Object> get props => [
        currentZone,
        nextZone,
      ];
}
