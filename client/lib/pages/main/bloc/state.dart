// External
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MainPageState extends Equatable {
  const MainPageState();

  @override
  List<Object> get props => [];
}

// Initial page state
class InitingState extends MainPageState {}

// State when all components are inited
class InitedState extends MainPageState {
  final LatLng position;

  const InitedState({required this.position});

  @override
  List<Object> get props => [position];
}

// State if location permission is not allowed
class LocationsPermissionIsNotAllowedState extends MainPageState {}

// State when couldn't get position
class CouldntGetPositionState extends MainPageState {}
