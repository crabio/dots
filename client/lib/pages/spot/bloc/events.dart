// External
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'package:dots_client/pages/spot/resources/player_position.dart';

class SpotPageEvent extends Equatable {
  const SpotPageEvent();

  @override
  List<Object> get props => [];
}

/// Event for initing all required components
class InitEvent extends SpotPageEvent {}

/// New players geo location event
class NewPlayersGeoPositionEvent extends SpotPageEvent {
  final LatLng playerPosition;
  final List<PlayerPosition> otherPlayersPositions;

  const NewPlayersGeoPositionEvent({
    required this.playerPosition,
    required this.otherPlayersPositions,
  });

  @override
  List<Object> get props => [playerPosition, otherPlayersPositions];
}
