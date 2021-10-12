// External
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final MapController mapController = MapController();
  final LatLng position;
  final double zoom;

  MapWidget({
    required this.position,
    required this.zoom,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mapController.onReady.then((_) => mapController.move(position, zoom));
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: position,
        zoom: zoom,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            // Spot position pointer
            Marker(
              point: position,
              builder: (ctx) => const Icon(
                Icons.location_on,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
