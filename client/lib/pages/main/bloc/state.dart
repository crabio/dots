// External
import 'package:latlong2/latlong.dart';

abstract class MainPageState {}

// Initial page state
class InitingState extends MainPageState {}

// State when all components are inited
class InitedState extends MainPageState {
  final LatLng position;

  InitedState({required this.position});
}

// State if location permission is not allowed
class LocationsPermissionIsNotAllowedState extends MainPageState {}

// State when couldn't get position
class CouldntGetPositionState extends MainPageState {}
