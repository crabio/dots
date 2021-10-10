// External
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'bloc/events.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class MainForm extends StatelessWidget {
  const MainForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        if (state is InitingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InitedState) {
          return Center(
              child: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  center: LatLng(
                    state.position.latitude,
                    state.position.longitude,
                  ),
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return Text("© OpenStreetMap contributors");
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(
                          state.position.latitude,
                          state.position.longitude,
                        ),
                        builder: (ctx) => Container(
                          child: FlutterLogo(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                key: const Key("btn_create_spot"),
                child: const Text("Create new spot"),
                onPressed: () =>
                    context.read<MainPageBloc>().add(CreateNewSpotEvent()),
              ),
            ],
          ));
        } else if (state is CreatingNewSpotState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewSpotCreatedState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("New spot UUID: ${state.spotUuid}"),
                ),
                ElevatedButton(
                  key: const Key("btn_create_spot"),
                  child: const Text("Create new spot"),
                  onPressed: () =>
                      context.read<MainPageBloc>().add(CreateNewSpotEvent()),
                ),
              ],
            ),
          );
        } else if (state is CreateSpotErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Error when create new spot: ${state.error}"),
                ),
                ElevatedButton(
                  key: const Key("btn_create_spot"),
                  child: const Text("Create new spot"),
                  onPressed: () =>
                      context.read<MainPageBloc>().add(CreateNewSpotEvent()),
                ),
              ],
            ),
          );
        }

        return Text("Unkown state: $state");
      },
    );
  }
}
