// External
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class SpotPageState extends Equatable {
  const SpotPageState();

  @override
  List<Object> get props => [];
}

// Initial page state
class InitingState extends SpotPageState {}

// State when all components are inited
class InitedState extends SpotPageState {
  final LatLng spotPosition;
  // Spot radius in meters
  final int zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  const InitedState({
    required this.spotPosition,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
  });

  @override
  List<Object> get props => [
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
