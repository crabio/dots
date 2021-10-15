// External
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MainPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event for initing all required components
class InitEvent extends MainPageEvent {}

/// New geo location event
class NewGeoPositionEvent extends MainPageEvent {
  final LatLng position;

  NewGeoPositionEvent({required this.position});

  @override
  List<Object> get props => [position];
}
