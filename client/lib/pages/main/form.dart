// External
import 'package:dots_client/pages/join/page.dart';
import 'package:dots_client/pages/spot_settings/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class MainForm extends StatelessWidget {
  final String playerUuid;
  final MapController mapController = MapController();

  MainForm({
    required this.playerUuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        if (state is InitingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InitedState) {
          return Stack(
            children: [
              _MapWidget(
                mapController: mapController,
                position: state.position,
                zoom: 17.0,
              ),
              // New spot button
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        key: const Key("btn_join_spot"),
                        child: const Text("Join spot"),
                        onPressed: () => navPopAndPush(
                          context,
                          JoinSpotPage(playerUuid: playerUuid),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: ElevatedButton(
                        key: const Key("btn_create_spot"),
                        child: const Text("Create new spot"),
                        onPressed: () => navPopAndPush(
                          context,
                          SpotSettingsPage(
                            playerUuid: playerUuid,
                            userPosition: state.position,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is CouldntGetPositionState) {
          return Stack(
            children: [
              _MapWidget(
                position: LatLng(
                  -19.135596599128128,
                  47.205291327230555,
                ),
                zoom: 17.0,
              ),
              const Center(
                child: Text("Couldn't get device position"),
              ),
            ],
          );
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _MapWidget extends StatelessWidget {
  final MapController? mapController;
  final LatLng position;
  final double zoom;

  const _MapWidget({
    this.mapController,
    required this.position,
    required this.zoom,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mapController != null) {
      mapController!.onReady.then(
        (_) => mapController!.move(position, 17.0),
      );
    }
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
