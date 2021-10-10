// External
import 'package:latlong2/latlong.dart';

abstract class SpotPageState {
  final LatLng spotPosition;

  SpotPageState({required this.spotPosition});
}

// Initial page state
class InitingState extends SpotPageState {
  InitingState({required spotPosition}) : super(spotPosition: spotPosition);
}

// State when all components are inited
class InitedState extends SpotPageState {
  final LatLng position;

  InitedState({required spotPosition, required this.position})
      : super(spotPosition: spotPosition);
}
