// External
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class SpotPageEvent extends Equatable {
  const SpotPageEvent();

  @override
  List<Object> get props => [];
}

/// Event for initing all required components
class InitEvent extends SpotPageEvent {}

/// New geo location event
class NewGeoPositionEvent extends SpotPageEvent {
  final LatLng position;

  const NewGeoPositionEvent({required this.position});

  @override
  List<Object> get props => [position];
}
