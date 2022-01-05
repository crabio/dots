import 'package:dots_client/pages/game/page.dart';
import 'package:dots_client/pages/main/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'bloc/bloc.dart';

class LobbyForm extends StatelessWidget {
  final String spotUuid;
  final String playerUuid;
  final bool isHost;

  const LobbyForm({
    required this.spotUuid,
    required this.playerUuid,
    required this.isHost,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LobbyPageBloc, LobbyPageState>(
      builder: (context, state) {
        if (state is LobbyPageInitial) {
          return _LobbyPageView(
            gettingPlayersList: state.gettingPlayersList,
            spotUuid: spotUuid,
            isHost: isHost,
            playersList: state.playersList,
            qrCodeData: state.qrCodeData,
          );
        } else if (state is GoToGameState) {
          navPopAndPushAfterBuild(
              context,
              GamePage(
                spotUuid: spotUuid,
                playerUuid: playerUuid,
                isHunter: state.isHunter,
                isHost: isHost,
              ));
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorState) {
          return Text("Init error: ${state.exception.toString()}");
        } else if (state is LeavingSpotState) {
          Future.delayed(
            Duration.zero,
            () => navPopAndPush(context, MainPage()),
          );
          return const Center(child: CircularProgressIndicator());
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _LobbyPageView extends StatelessWidget {
  final bool gettingPlayersList;
  final String spotUuid;
  final bool isHost;
  final List<String> playersList;
  final String qrCodeData;
  final Exception? exception;

  const _LobbyPageView({
    required this.gettingPlayersList,
    required this.spotUuid,
    required this.isHost,
    required this.playersList,
    required this.qrCodeData,
    this.exception,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.list,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.qr_code,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(children: [
              _PlayersListView(
                spotUuid: spotUuid,
                isHost: isHost,
                playersList: playersList,
                exception: exception,
              ),
              _QrCodeView(qrCodeData: qrCodeData),
            ]),
          ),
        ],
      ),
    );
  }
}

class _PlayersListView extends StatelessWidget {
  final String spotUuid;
  final bool isHost;
  final List<String> playersList;
  final Exception? exception;

  const _PlayersListView({
    required this.spotUuid,
    required this.isHost,
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
            child: SelectableText("Lobby $spotUuid"),
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
          isHost
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    key: const Key("btn_start"),
                    child: const Text("Start"),
                    onPressed: () => context
                        .read<LobbyPageBloc>()
                        .add(const StartGameEvent()),
                  ),
                )
              : Container(),
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

class _QrCodeView extends StatelessWidget {
  final String qrCodeData;

  const _QrCodeView({
    required this.qrCodeData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: QrImage(data: qrCodeData),
      ),
    );
  }
}
