// External
import 'package:dots_client/pages/spot/bloc/events.dart';
import 'package:dots_client/pages/spot/resources/player_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class SpotForm extends StatelessWidget {
  final String spotUuid;

  const SpotForm({
    required this.spotUuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotPageBloc, SpotPageState>(
      builder: (context, state) {
        if (state is InitingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is IdleState) {
          return _IdleStateView(
            spotUuid: spotUuid,
            playersList: state.playersList,
          );
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _IdleStateView extends StatelessWidget {
  final String spotUuid;
  final List<String> playersList;

  const _IdleStateView({
    required this.spotUuid,
    required this.playersList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text("Spot #$spotUuid"),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              key: const Key("btn_start"),
              child: const Text("Start"),
              onPressed: () =>
                  context.read<SpotPageBloc>().add(StartGameEvent()),
            ),
          ),
          ListView.builder(
            itemCount: playersList.length,
            itemBuilder: (context, index) {
              final item = playersList[index];
              return ListTile(
                title: Text("Player #$index"),
                subtitle: Text(item),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InitedStateView extends StatelessWidget {
  final PlayerState playerState;
  final Map<String, PlayerState> otherPlayersStates;
  final LatLng spotPosition;
  // Spot radius in meters
  final int zoneRadius;

  const _InitedStateView({
    required this.playerState,
    required this.otherPlayersStates,
    required this.spotPosition,
    required this.zoneRadius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[];
    // Spot position pointer
    markers.add(Marker(
      point: spotPosition,
      builder: (ctx) => const Icon(
        Icons.location_pin,
        size: 40,
        color: Colors.red,
      ),
    ));
    // Player position pointer
    markers.add(Marker(
      point: playerState.position,
      builder: (ctx) => const Icon(
        Icons.circle,
      ),
    ));

    // Other players pointers
    otherPlayersStates.forEach((key, value) {
      markers.add(Marker(
        point: value.position,
        builder: (ctx) => const Icon(
          Icons.circle,
          color: Colors.amber,
        ),
      ));
    });

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: playerState.position,
            zoom: 17.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: markers),
            CircleLayerOptions(circles: [
              CircleMarker(
                point: spotPosition,
                useRadiusInMeter: true,
                color: const Color.fromRGBO(0, 0, 0, 0),
                borderColor: Colors.red,
                borderStrokeWidth: 2,
                radius: zoneRadius.toDouble(),
              ),
            ])
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "Health: ${playerState.health}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: _healthColor(playerState.health)),
                  ),
                ),
                CircularProgressIndicator(
                  value: playerState.health / 100,
                  strokeWidth: 10,
                  color: _healthColor(playerState.health),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _healthColor(int health) {
    if (health > 60) {
      return Colors.green;
    } else if (health > 30) {
      return Colors.orange;
    } else if (health > 0) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}
