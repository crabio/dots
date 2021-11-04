import 'package:dots_client/pages/game/resources/player_state.dart';
import 'package:dots_client/pages/game/resources/session_winner.dart';
import 'package:dots_client/pages/game/resources/zone_state.dart';
import 'package:dots_client/pages/lobby/form.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'bloc/bloc.dart';

class GameForm extends StatelessWidget {
  final String spotUuid;
  final String playerUuid;
  final bool isHost;

  const GameForm({
    required this.spotUuid,
    required this.playerUuid,
    required this.isHost,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamePageBloc, GamePageState>(
      builder: (context, state) {
        if (state is GamePageInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InitedState) {
          return _InitedStateView(
            playerState: state.playerState,
            otherPlayersStates: state.otherPlayersStates,
            currentZone: state.currentZone,
            nextZone: state.nextZone,
            nextZoneTime: state.nextZoneTime,
            zoneTickStartTimestamp: state.zoneTickStartTimestamp,
          );
        } else if (state is HunterWinsState) {
          Future.delayed(
            const Duration(seconds: 10),
            () => navPopAndPush(
              context,
              LobbyForm(
                spotUuid: spotUuid,
                playerUuid: playerUuid,
                isHost: isHost,
              ),
            ),
          );
          return const Center(
            child: Text("Hunter wins!"),
          );
        } else if (state is VictimsWinsState) {
          Future.delayed(
            const Duration(seconds: 10),
            () => navPopAndPush(
              context,
              LobbyForm(
                spotUuid: spotUuid,
                playerUuid: playerUuid,
                isHost: isHost,
              ),
            ),
          );
          return const Center(
            child: Text("Victoms wins!"),
          );
        } else if (state is DrawState) {
          Future.delayed(
            const Duration(seconds: 10),
            () => navPopAndPush(
              context,
              LobbyForm(
                spotUuid: spotUuid,
                playerUuid: playerUuid,
                isHost: isHost,
              ),
            ),
          );
          return const Center(
            child: Text("Looks like it is draw!"),
          );
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _InitedStateView extends StatelessWidget {
  final PlayerState playerState;
  final Map<String, PlayerState> otherPlayersStates;

  final ZoneState? currentZone;
  final ZoneState? nextZone;

  final DateTime? nextZoneTime;
  final DateTime? zoneTickStartTimestamp;

  const _InitedStateView({
    required this.playerState,
    required this.otherPlayersStates,
    this.currentZone,
    this.nextZone,
    this.nextZoneTime,
    this.zoneTickStartTimestamp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[];
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

    final circles = <CircleMarker>[];
    if (currentZone != null) {
      circles.add(CircleMarker(
        point: currentZone!.position,
        useRadiusInMeter: true,
        color: const Color.fromRGBO(0, 0, 0, 0),
        borderColor: Colors.red,
        borderStrokeWidth: 2,
        radius: currentZone!.radiusInM.toDouble(),
      ));
    }
    if (nextZone != null) {
      circles.add(CircleMarker(
        point: nextZone!.position,
        useRadiusInMeter: true,
        color: const Color.fromRGBO(0, 0, 0, 0),
        borderColor: Colors.blue,
        borderStrokeWidth: 2,
        radius: nextZone!.radiusInM.toDouble(),
      ));
    }

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
            CircleLayerOptions(circles: circles)
          ],
        ),
        Positioned(
          right: 10,
          top: 0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "Health: ${playerState.health.toStringAsFixed(1)}",
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
        // Zone vevent widget
        Positioned(
          top: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    nextZoneTime != null
                        ? "Next zone in ${prettyDuration(nextZoneTime!.difference(DateTime.now()))}"
                        : zoneTickStartTimestamp != null
                            ? "Zone tick in ${prettyDuration(zoneTickStartTimestamp!.difference(DateTime.now()))}"
                            : "Zone is ticking",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _healthColor(double health) {
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
