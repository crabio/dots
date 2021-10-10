import 'package:geolocator/geolocator.dart';

abstract class MainPageState {}

// Initial page state
class InitingState implements MainPageState {}

// State when all components are inited
class InitedState implements MainPageState {
  final Position position;

  InitedState({required this.position});
}

// State if location permission is not allowed
class LocationsPermissionIsNotAllowedState implements MainPageState {}

// State when creating new spot on server
class CreatingNewSpotState implements MainPageState {}

// State when new spot created
class NewSpotCreatedState implements MainPageState {
  final String spotUuid;

  NewSpotCreatedState({required this.spotUuid});
}

// State when couldn't create spot
class CreateSpotErrorState implements MainPageState {
  final String error;

  CreateSpotErrorState({required this.error});
}
