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
  List<Object> get props => [];
}

// Initial page state
class InitingState extends SpotPageState {}

// State when all components are inited
@CopyWith()
class InitedState extends SpotPageState {
  final LatLng playerPosition;
  final int playerHealth;
  final List<PlayerPosition> otherPlayersPositions;

  final LatLng spotPosition;
  // Spot radius in meters
  final int zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  const InitedState({
    required this.playerPosition,
    required this.playerHealth,
    required this.otherPlayersPositions,
    required this.spotPosition,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
  });

  @override
  List<Object> get props => [
        playerPosition,
        playerHealth,
        otherPlayersPositions,
        spotPosition,
        zoneRadius,
        scanPeriod,
        zonePeriod,
      ];
}

// State inited with error
class InitErrorState extends SpotPageState {
  final Exception exception;

  const InitErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}
