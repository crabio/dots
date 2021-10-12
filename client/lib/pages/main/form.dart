// External
import 'package:dots_client/pages/spot_settings/page.dart';
import 'package:dots_client/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class MainForm extends StatelessWidget {
  final MapController mapController = MapController();

  MainForm({Key? key}) : super(key: key);

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
              MapWidget(
                mapController: mapController,
                position: state.position,
                zoom: 17.0,
              ),
              // New spot button
              _CreateNewSpotBtn(position: state.position),
            ],
          );
        } else if (state is CouldntGetPositionState) {
          return Stack(
            children: [
              MapWidget(
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

class _CreateNewSpotBtn extends StatelessWidget {
  final LatLng position;

  const _CreateNewSpotBtn({
    required this.position,
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
              child: const Text("Create new spot"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SpotSettingsPage(
                    userPosition: position,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
