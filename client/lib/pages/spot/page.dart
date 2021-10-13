// External
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'form.dart';
import 'bloc/bloc.dart';

class SpotPage extends StatelessWidget {
  final String spotUuid;
  final LatLng spotPosition;

  const SpotPage({
    required this.spotUuid,
    required this.spotPosition,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpotPageBloc(
        spotPosition: spotPosition,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dots'),
          actions: [
            IconButton(
              onPressed: () => navPush(
                context,
                const SettingsPage(),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: const SpotForm(),
      ),
    );
  }
}
