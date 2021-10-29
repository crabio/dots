import 'package:latlong2/latlong.dart';

class ZoneState {
  final LatLng position;
  int radiusInM;
  double damage;

  ZoneState({
    required this.position,
    required this.radiusInM,
    required this.damage,
  });
}
