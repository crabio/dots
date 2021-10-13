// External
import 'package:latlong2/latlong.dart';

abstract class SpotPageEvent {}

/// Event for initing all required components
class InitEvent extends SpotPageEvent {
  final String spotUuid;

  InitEvent({required this.spotUuid});
}

/// New geo location event
class NewGeoPositionEvent extends SpotPageEvent {
  final LatLng position;

  NewGeoPositionEvent({required this.position});
}
