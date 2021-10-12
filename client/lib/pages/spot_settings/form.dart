// External
import 'package:dots_client/widgets/map.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:numberpicker/numberpicker.dart';

// Internal
import 'bloc/events.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class SpotSettingsForm extends StatelessWidget {
  final MapController mapController = MapController();

  SpotSettingsForm({
    Key? key,
  }) : super(key: key);

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
                MapWidget(
                  mapController: mapController,
                  position: curState.position,
                  zoom: 17.0,
                ),
                const Text("Radius in meters"),
                NumberPicker(
                  minValue: 0,
                  maxValue: 1000,
                  value: curState.radius,
                  onChanged: (value) => context
                      .read<SpotSettingsPageBloc>()
                      .add(NewRadiusEvent(value: value)),
                ),
                const Text("Scan time"),
                DurationPicker(
                  duration: curState.scanPeriod,
                  onChange: (value) => context
                      .read<SpotSettingsPageBloc>()
                      .add(NewScanDurationEvent(value: value)),
                ),
                const Text("Zone time"),
                DurationPicker(
                  duration: curState.scanPeriod,
                  onChange: (value) => context
                      .read<SpotSettingsPageBloc>()
                      .add(NewZoneDurationEvent(value: value)),
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
