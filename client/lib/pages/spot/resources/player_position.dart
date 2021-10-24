// External
import 'package:latlong2/latlong.dart';

class PlayerState {
  final LatLng position;
  final int health;

  PlayerState({
    required this.position,
    required this.health,
  });
}
