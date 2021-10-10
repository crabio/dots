// External
import 'package:latlong2/latlong.dart';

abstract class MainPageState {}

// Initial page state
class InitingState implements MainPageState {}

// State when all components are inited
class InitedState implements MainPageState {
  final LatLng position;

  InitedState({required this.position});
}

// State if location permission is not allowed
class LocationsPermissionIsNotAllowedState implements MainPageState {}

// State when creating new spot on server
class CreatingNewSpotState implements MainPageState {}

// State when new spot created
class NewSpotCreatedState implements MainPageState {
  final String spotUuid;
  final LatLng position;

  NewSpotCreatedState({
    required this.spotUuid,
    required this.position,
  });
}

// State when couldn't create spot
class CreateSpotErrorState implements MainPageState {
  final String error;

  CreateSpotErrorState({required this.error});
}
