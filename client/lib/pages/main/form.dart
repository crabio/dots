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

class MainForm extends StatelessWidget {
  MainForm({Key? key}) : super(key: key);

  final MapController mapController = MapController();

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
          return _buildNewSpotCreatedState(context, state);
        } else if (state is CreateSpotErrorState) {
          return _buildCreateSpotErrorState(context, state);
        }

        return Text("Unkown state: $state");
      },
    );
  }

  Widget _buildMap({
    required Position position,
    required double zoom,
  }) {
    final center = LatLng(
      position.latitude,
      position.longitude,
    );
    mapController.onReady.then((_) => mapController.move(center, zoom));
    return FlutterMap(
      options: MapOptions(
        center: center,
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
              point: center,
              builder: (ctx) => const Icon(
                Icons.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCreateNewSpotBtn(BuildContext context) {
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
              onPressed: () =>
                  context.read<MainPageBloc>().add(CreateNewSpotEvent()),
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
        _buildCreateNewSpotBtn(context),
      ],
    );
  }

  Widget _buildNewSpotCreatedState(
    BuildContext context,
    NewSpotCreatedState state,
  ) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text("New spot UUID: ${state.spotUuid}"),
          ),
        ),
        _buildCreateNewSpotBtn(context),
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
        _buildCreateNewSpotBtn(context),
      ],
    );
  }
}
