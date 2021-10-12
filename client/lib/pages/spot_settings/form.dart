// External
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'bloc/events.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class SpotSettingsForm extends StatelessWidget {
  SpotSettingsForm({Key? key}) : super(key: key);

  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotSettingsPageBloc, SpotSettingsPageState>(
      builder: (context, state) {
        final curState = state;
        if (curState is InitedState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Location"),
                _MapWidget(
                  position: curState.position,
                  zoom: 17.0,
                ),
                const Text("Radius"),
                // TODO Radius picker
                const Text("Scan time"),
                // TODO time pciker
                const Text("Zone time"),
                // TODO time pciker
              ],
            ),
          );
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _MapWidget extends StatelessWidget {
  final LatLng position;
  final double zoom;

  const _MapWidget({
    required this.position,
    required this.zoom,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
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
