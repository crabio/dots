// External
import 'package:dots_client/api/connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'package:dots_client/pages/main/page.dart';
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'form.dart';
import 'bloc/bloc.dart';

class SpotSettingsPage extends StatelessWidget {
  final String playerUuid;
  final LatLng userPosition;

  const SpotSettingsPage({
    required this.playerUuid,
    required this.userPosition,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpotSettingsPageBloc(
        playerUuid: playerUuid,
        client: RepositoryProvider.of<SpotServiceConnector>(context).connect,
        position: userPosition,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Spot settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => navPopAndPush(
              context,
              MainPage(),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: SpotSettingsForm(
          playerUuid: playerUuid,
        ),
      ),
    );
  }
}
