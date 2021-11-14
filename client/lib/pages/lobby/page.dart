import 'package:dots_client/api/connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        client: RepositoryProvider.of<SpotServiceConnector>(context).connect,
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
            BlocBuilder<LobbyPageBloc, LobbyPageState>(
                builder: (context, state) {
              return IconButton(
                onPressed: () =>
                    context.read<LobbyPageBloc>().add(const LeaveSpotEvent()),
                icon: const Icon(Icons.close),
              );
            }),
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
