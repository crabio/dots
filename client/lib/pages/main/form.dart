// External
import 'package:dots_client/pages/spot/page.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'bloc/events.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class MainForm extends StatelessWidget {
  final AppSettings settings;
  final MapController mapController = MapController();

  MainForm({required this.settings, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        if (state is InitingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InitedState) {
          return _buildInitedState(context, state);
        } else if (state is CreatingNewSpotState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewSpotCreatedState) {
          // Add zero duration to perform navigation after render
          Future.delayed(
            Duration.zero,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SpotPage(
                      settings: settings,
                      spotUuid: state.spotUuid,
                      spotPosition: state.position)),
            ),
          );
          return Container();
        } else if (state is CreateSpotErrorState) {
          return _buildCreateSpotErrorState(context, state);
        }

        return Text("Unkown state: $state");
      },
    );
  }

  Widget _buildMap({
    required LatLng position,
    required double zoom,
  }) {
    mapController.onReady.then((_) => mapController.move(position, zoom));
    return FlutterMap(
      options: MapOptions(
        center: position,
        zoom: zoom,
      ),
      mapController: mapController,
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          // attributionBuilder: (_) {
          //   return Text("© OpenStreetMap contributors");
          // },
        ),
        MarkerLayerOptions(
          markers: [
            // User position pointer
            Marker(
              point: position,
              builder: (ctx) => const Icon(
                Icons.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCreateNewSpotBtn(BuildContext context, LatLng position) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              key: const Key("btn_create_spot"),
              child: const Text("Create new spot"),
              onPressed: () => context
                  .read<MainPageBloc>()
                  .add(CreateNewSpotEvent(position: position)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitedState(
    BuildContext context,
    InitedState state,
  ) {
    return Stack(
      children: [
        _buildMap(position: state.position, zoom: 17.0),
        _buildCreateNewSpotBtn(context, state.position),
      ],
    );
  }

  Widget _buildCreateSpotErrorState(
    BuildContext context,
    CreateSpotErrorState state,
  ) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text("Error when create new spot: ${state.error}"),
          ),
        ),
      ],
    );
  }
}
