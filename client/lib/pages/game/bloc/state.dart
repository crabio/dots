part of 'bloc.dart';

@immutable
abstract class GamePageState extends Equatable {
  const GamePageState();

  @override
  List<Object> get props => [];
}

class GamePageInitial extends GamePageState {}

// State when game is running
class InitedState extends GamePageState {
  /// Current player state
  final PlayerState playerState;

  /// Map with other players states
  /// key - player uuid
  /// value - player state
  final Map<String, PlayerState> otherPlayersStates;

  final LatLng spotPosition;
  final int zoneRadius;

  const InitedState({
    required this.playerState,
    required this.otherPlayersStates,
    required this.spotPosition,
    required this.zoneRadius,
  });

  @override
  List<Object> get props => [
        playerState,
        otherPlayersStates,
        spotPosition,
        zoneRadius,
      ];
}

// State inited with error
class InitErrorState extends GamePageState {
  final Exception exception;

  const InitErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}
