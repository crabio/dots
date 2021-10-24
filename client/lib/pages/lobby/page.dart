// External
import 'package:dots_client/pages/main/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'form.dart';
import 'bloc/bloc.dart';

class LobbyPage extends StatelessWidget {
  final String spotUuid;
  final String playerUuid;

  /// Flag indicies that current player is spot host
  final bool isHost;

  const LobbyPage({
    required this.spotUuid,
    required this.playerUuid,
    required this.isHost,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LobbyPageBloc(
        client: RepositoryProvider.of<proto.SpotServiceClient>(context),
        geolocator: RepositoryProvider.of(context),
        spotUuid: spotUuid,
        playerUuid: playerUuid,
        isHost: isHost,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lobby: $spotUuid',
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
        body: LobbyForm(
          spotUuid: spotUuid,
          playerUuid: playerUuid,
          isHost: isHost,
        ),
      ),
    );
  }
}