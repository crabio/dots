// External
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

// Internal

class SpotPageEvent extends Equatable {
  const SpotPageEvent();

  @override
  List<Object> get props => [];
}

/// Event for initing all required components
class InitEvent extends SpotPageEvent {}

class NewSpotPlayersListEvent extends SpotPageEvent {
  final List<String> playersList;

  const NewSpotPlayersListEvent({required this.playersList});

  @override
  List<Object> get props => [playersList];
}

class StartGameEvent extends SpotPageEvent {}

/// New players states event
class NewPlayersStatesEvent extends SpotPageEvent {
  final String playerUuid;
  final LatLng playerPosition;
  final int playerHealth;

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
