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
