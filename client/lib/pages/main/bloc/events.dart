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
