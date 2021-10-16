// External
import 'package:latlong2/latlong.dart';

class PlayerPosition {
  final String playerUuid;
  final LatLng position;

  PlayerPosition({
    required this.playerUuid,
    required this.position,
  });
}
