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

// State when creating new spot on server
class CreatingNewSpotState extends MainPageState {}

// State when new spot created
class NewSpotCreatedState extends MainPageState {
  final String spotUuid;
  final LatLng position;

  NewSpotCreatedState({
    required this.spotUuid,
    required this.position,
  });
}

// State when couldn't get position
class CouldntGetPositionState extends MainPageState {}

// State when couldn't create spot
class CreateSpotErrorState extends MainPageState {
  final String error;

  CreateSpotErrorState({required this.error});
}
