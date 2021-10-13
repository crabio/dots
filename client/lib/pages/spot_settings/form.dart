// External
import 'package:dots_client/pages/spot/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:numberpicker/numberpicker.dart';

// Internal
import 'bloc/events.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class SpotSettingsForm extends StatelessWidget {
  const SpotSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotSettingsPageBloc, SpotSettingsPageState>(
      builder: (context, state) {
        final curState = state;
        if (curState is InitedState) {
          return _SpotSettingsForm(
            position: curState.position,
            radius: curState.radius,
            scanPeriod: curState.scanPeriod,
            zonePeriod: curState.zonePeriod,
          );
        } else if (curState is CreatingNewSpotState) {
          return _SpotSettingsForm(
            position: curState.position,
            radius: curState.radius,
            scanPeriod: curState.scanPeriod,
            zonePeriod: curState.zonePeriod,
            creatingSpot: true,
          );
        } else if (curState is NewSpotCreatedState) {
          navPushAfterBuild(
            context,
            SpotPage(
              spotUuid: curState.spotUuid,
              spotPosition: curState.position,
            ),
          );
          return const CircularProgressIndicator();
        } else if (curState is CreateSpotErrorState) {
          return _SpotSettingsForm(
            position: curState.position,
            radius: curState.radius,
            scanPeriod: curState.scanPeriod,
            zonePeriod: curState.zonePeriod,
            exception: curState.exception,
          );
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _SpotSettingsForm extends StatelessWidget {
  static const zoom = 17.0;

  final LatLng position;

  /// Spot radius in meters
  final int radius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  /// Exception on creating new spot on server
  final Exception? exception;

  final bool creatingSpot;

  const _SpotSettingsForm({
    required this.position,
    required this.radius,
    required this.scanPeriod,
    required this.zonePeriod,
    this.exception,
    this.creatingSpot = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            exception != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text(
                      exception.toString(),
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
                options: MapOptions(
                  center: position,
                  zoom: zoom,
                ),
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
                        radius: radius.toDouble(),
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
              minValue: 0,
              maxValue: 1000,
              value: radius,
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
            creatingSpot
                ? const CircularProgressIndicator()
                : _CreateNewSpotBtn(
                    position: position,
                    radius: radius,
                    scanPeriod: scanPeriod,
                    zonePeriod: zonePeriod,
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
  final int radius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  const _CreateNewSpotBtn({
    required this.position,
    required this.radius,
    required this.scanPeriod,
    required this.zonePeriod,
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
                        radius: radius,
                        scanPeriod: scanPeriod,
                        zonePeriod: zonePeriod,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
