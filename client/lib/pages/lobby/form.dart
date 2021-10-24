// External
import 'package:dots_client/pages/game/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'bloc/bloc.dart';

class LobbyForm extends StatelessWidget {
  final String spotUuid;
  final String playerUuid;

  const LobbyForm({
    required this.spotUuid,
    required this.playerUuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LobbyPageBloc, LobbyPageState>(
      builder: (context, state) {
        if (state is InitingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InitedState) {
          return _InitedStateView(
            spotUuid: spotUuid,
            playersList: state.playersList,
          );
        } else if (state is GoToGameState) {
          navPopAndPush(
              context,
              GamePage(
                spotUuid: spotUuid,
                playerUuid: playerUuid,
              ));
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InitErrorState) {
          return Text("Init error: ${state.exception.toString()}");
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _InitedStateView extends StatelessWidget {
  final String spotUuid;
  final List<String> playersList;
  final Exception? exception;

  const _InitedStateView({
    required this.spotUuid,
    required this.playersList,
    this.exception,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text("Lobby $spotUuid"),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: exception != null
                ? Text(
                    exception.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.red),
                  )
                : Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              key: const Key("btn_start"),
              child: const Text("Start"),
              onPressed: () =>
                  context.read<LobbyPageBloc>().add(StartGameEvent()),
            ),
          ),
          SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: playersList.length,
              itemBuilder: (context, index) {
                final item = playersList[index];
                return ListTile(
                  title: Text("Player #$index"),
                  subtitle: Text(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
