// External
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

// Internal
import 'package:dots_client/pages/spot/resources/player_position.dart';
part 'state.g.dart';

abstract class SpotPageState extends Equatable {
  const SpotPageState();

  @override
  List<Object?> get props => [];
}

// Initial page state
class InitingState extends SpotPageState {}

// State when spot is not active (not playing)
@CopyWith()
class IdleState extends SpotPageState {
  final List<String> playersList;
  final Exception? exception;

  const IdleState({
    required this.playersList,
    this.exception,
  });

  @override
  List<Object?> get props => [
        playersList,
        exception,
      ];
}

// State when game is running
@CopyWith()
class ActiveState extends SpotPageState {
  /// Current player state
  final PlayerState? playerState;

  /// Map with other players states
  /// key - player uuid
  /// value - player state
  final Map<String, PlayerState> otherPlayersStates;

  final LatLng spotPosition;
  final int zoneRadius;

  const ActiveState({
    this.playerState,
    required this.otherPlayersStates,
    required this.spotPosition,
    required this.zoneRadius,
  });

  @override
  List<Object?> get props => [
        playerState,
        otherPlayersStates,
        spotPosition,
        zoneRadius,
      ];
}

// State inited with error
class InitErrorState extends SpotPageState {
  final Exception exception;

  const InitErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}
