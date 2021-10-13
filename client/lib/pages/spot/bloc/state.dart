// External
import 'package:latlong2/latlong.dart';

abstract class SpotPageState {}

// Initial page state
class InitingState extends SpotPageState {}

// State when all components are inited
class InitedState extends SpotPageState {
  final LatLng spotPosition;
  // Spot radius in meters
  final int zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  InitedState({
    required this.spotPosition,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
  });
}

// State inited with error
class InitErrorState extends SpotPageState {
  final Exception exception;

  InitErrorState({required this.exception});
}
