// External
import 'package:latlong2/latlong.dart';

abstract class MainPageEvent {}

/// Event for initing all required components
class InitEvent extends MainPageEvent {}

/// New geo location event
class NewGeoPositionEvent extends MainPageEvent {
  final LatLng position;

  NewGeoPositionEvent({required this.position});
}

/// Create new spot event
class CreateNewSpotEvent extends MainPageEvent {
  final LatLng position;

  CreateNewSpotEvent({required this.position});
}

/// New spot created event
class NewSpotCreatedEvent extends MainPageEvent {
  final String spotUuid;
  final LatLng position;

  NewSpotCreatedEvent({
    required this.spotUuid,
    required this.position,
  });
}
