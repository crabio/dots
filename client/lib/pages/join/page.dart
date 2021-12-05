import 'package:dots_client/api/connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'form.dart';
import 'bloc/bloc.dart';

class JoinSpotPage extends StatelessWidget {
  final String playerUuid;

  const JoinSpotPage({
    required this.playerUuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JoinSpotPageBloc(
        client: RepositoryProvider.of<SpotServiceConnector>(context).connect,
        playerUuid: playerUuid,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Join to spot',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
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
        body: JoinSpotForm(playerUuid: playerUuid),
      ),
    );
  }
}
