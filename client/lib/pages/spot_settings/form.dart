// External
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:numberpicker/numberpicker.dart';

// Internal
import 'package:dots_client/utils/nav.dart';
import 'package:dots_client/pages/spot/page.dart';
import 'bloc/events.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class SpotSettingsForm extends StatelessWidget {
  final mapController = MapController();

  SpotSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotSettingsPageBloc, SpotSettingsPageState>(
      builder: (context, state) {
        final curState = state;
        if (curState is InitedState) {
          return _SpotSettingsForm(
            mapController: mapController,
            position: curState.position,
            zoneRadius: curState.zoneRadius,
            scanPeriod: curState.scanPeriod,
            zonePeriod: curState.zonePeriod,
            sessionDuration: curState.sessionDuration,
            creatingSpot: curState.creating,
            error: curState.error,
          );
        } else if (curState is NewSpotCreatedState) {
          navPopAndPushAfterBuild(
            context,
            SpotPage(
              spotUuid: curState.spotUuid,
            ),
          );
          return const CircularProgressIndicator();
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _SpotSettingsForm extends StatelessWidget {
  final MapController mapController;
  final LatLng position;

  /// Spot radius in meters
  final int zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;
  final Duration sessionDuration;

  /// Error on creating new spot on server
  final String error;

  final bool creatingSpot;

  const _SpotSettingsForm({
    required this.mapController,
    required this.position,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
    required this.sessionDuration,
    this.error = "",
    this.creatingSpot = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mapController.onReady.then(
      (_) => mapController.move(position, 18 - sqrt((zoneRadius / 40))),
    );
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            error.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text(
                      error,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                : Container(),
            const Text("Location"),
            SizedBox(
              width: 300,
              height: 300,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                  CircleLayerOptions(
                    circles: [
                      CircleMarker(
                        point: position,
                        radius: zoneRadius.toDouble(),
                        useRadiusInMeter: true,
                        color: const Color.fromRGBO(0, 0, 0, 0),
                        borderColor: Colors.red,
                        borderStrokeWidth: 2.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Text("Radius in meters"),
            NumberPicker(
              axis: Axis.horizontal,
              step: 10,
              minValue: 40,
              maxValue: 1000,
              value: zoneRadius,
              onChanged: (value) => context
                  .read<SpotSettingsPageBloc>()
                  .add(NewRadiusEvent(value: value)),
            ),
            const Text("Scan time in seconds"),
            NumberPicker(
              axis: Axis.horizontal,
              step: 10,
              minValue: 0,
              maxValue: 1000,
              value: scanPeriod.inSeconds,
              onChanged: (value) => context
                  .read<SpotSettingsPageBloc>()
                  .add(NewScanDurationEvent(value: Duration(seconds: value))),
            ),
            const Text("Zone time in seconds"),
            NumberPicker(
              axis: Axis.horizontal,
              step: 10,
              minValue: 0,
              maxValue: 1000,
              value: zonePeriod.inSeconds,
              onChanged: (value) => context
                  .read<SpotSettingsPageBloc>()
                  .add(NewZoneDurationEvent(value: Duration(seconds: value))),
            ),
            const Text("Session duration in seconds"),
            NumberPicker(
              axis: Axis.horizontal,
              step: 10,
              minValue: 0,
              maxValue: 3600,
              value: zonePeriod.inSeconds,
              onChanged: (value) => context
                  .read<SpotSettingsPageBloc>()
                  .add(NewZoneDurationEvent(value: Duration(seconds: value))),
            ),
            creatingSpot
                ? const CircularProgressIndicator()
                : _CreateNewSpotBtn(
                    position: position,
                    zoneRadius: zoneRadius,
                    scanPeriod: scanPeriod,
                    zonePeriod: zonePeriod,
                    sessionDuration: sessionDuration,
                  ),
          ],
        ),
      ),
    );
  }
}

class _CreateNewSpotBtn extends StatelessWidget {
  final LatLng position;
  // Spot radius in meters
  final int zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;
  final Duration sessionDuration;

  const _CreateNewSpotBtn({
    required this.position,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
    required this.sessionDuration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: const Text("Create"),
              onPressed: () =>
                  context.read<SpotSettingsPageBloc>().add(CreateNewSpotEvent(
                        position: position,
                        zoneRadius: zoneRadius,
                        scanPeriod: scanPeriod,
                        zonePeriod: zonePeriod,
                        sessionDuration: sessionDuration,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
