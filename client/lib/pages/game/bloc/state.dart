part of 'bloc.dart';

@immutable
abstract class GamePageState extends Equatable {
  const GamePageState();

  @override
  List<Object?> get props => [];
}

class GamePageInitial extends GamePageState {}

// State when game is running
@CopyWith()
class InitedState extends GamePageState {
  /// Current player state
  final PlayerState playerState;

  /// Map with other players states
  /// key - player uuid
  /// value - player state
  final Map<String, PlayerState> otherPlayersStates;

  final ZoneState? currentZone;
  final DateTime? nextZoneTime;
  final ZoneState? nextZone;
  final DateTime? zoneTickStartTimestamp;

  const InitedState({
    required this.playerState,
    required this.otherPlayersStates,
    this.currentZone,
    this.nextZoneTime,
    this.nextZone,
    this.zoneTickStartTimestamp,
  });

  @override
  List<Object?> get props => [
        playerState,
        otherPlayersStates,
        currentZone,
        nextZoneTime,
      ];
}

// State inited with error
class ErrorState extends GamePageState {
  final Exception exception;

  const ErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}
