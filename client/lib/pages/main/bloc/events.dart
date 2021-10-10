import 'package:geolocator/geolocator.dart';

abstract class MainPageEvent {}

/// Event for initing all required components
class InitEvent extends MainPageEvent {}

/// New geo location event
class NewGeoPositionEvent extends MainPageEvent {
  final Position position;

  NewGeoPositionEvent({required this.position});
}

/// Create new spot event
class CreateNewSpotEvent extends MainPageEvent {}

/// New spot created event
class NewSpotCreatedEvent extends MainPageEvent {
  final String spotUuid;

  NewSpotCreatedEvent({required this.spotUuid});
}
