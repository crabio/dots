// External
import 'package:dots_client/api/connector.dart';
import 'package:dots_client/pages/main/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'form.dart';
import 'bloc/bloc.dart';

class GamePage extends StatelessWidget {
  final String spotUuid;
  final String playerUuid;
  final bool isHunter;

  const GamePage({
    required this.spotUuid,
    required this.playerUuid,
    required this.isHunter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GamePageBloc(
        client: RepositoryProvider.of<SpotServiceConnector>(context).connect,
        geolocator: RepositoryProvider.of(context),
        spotUuid: spotUuid,
        playerUuid: playerUuid,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Spot: $spotUuid',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            IconButton(
              onPressed: () => navPopAndPush(
                context,
                MainPage(),
              ),
              icon: const Icon(Icons.close),
            ),
            IconButton(
              onPressed: () => navPush(
                context,
                const SettingsPage(),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: GameForm(
          spotUuid: spotUuid,
        ),
      ),
    );
  }
}
