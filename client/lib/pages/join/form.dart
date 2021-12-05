import 'package:dots_client/pages/lobby/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'bloc/bloc.dart';

class JoinSpotForm extends StatelessWidget {
  final String playerUuid;

  const JoinSpotForm({
    required this.playerUuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinSpotPageBloc, JoinSpotPageState>(
      builder: (context, state) {
        if (state is JoinSpotPageInitial) {
          return _InitialView(spotUuid: state.spotUuid, error: state.error);
        } else if (state is JoinedSpotState) {
          Future.delayed(
            Duration.zero,
            () => navPopAndPush(
                context,
                LobbyPage(
                  spotUuid: state.spotUuid,
                  playerUuid: playerUuid,
                  isHost: false,
                )),
          );
          return const Center(child: CircularProgressIndicator());
        }

        return Text("Unkown state: $state");
      },
    );
  }
}

class _InitialView extends StatelessWidget {
  final String spotUuid;
  final String error;

  const _InitialView({
    required this.spotUuid,
    required this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TabBar(
            tabs: [
              Icon(Icons.text_fields),
              Icon(Icons.qr_code),
            ],
          ),
          TabBarView(children: [
            _TextInputView(
              spotUuid: spotUuid,
              error: error,
            ),
            _QrCodeView(
              error: error,
            ),
          ])
        ],
      ),
    );
  }
}

class _TextInputView extends StatelessWidget {
  final String spotUuid;
  final String error;

  const _TextInputView({
    required this.spotUuid,
    required this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        error.isNotEmpty
            ? Text(
                error,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).colorScheme.error),
              )
            : Container(),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Spot uuid',
          ),
          onChanged: (value) => context
              .read<JoinSpotPageBloc>()
              .add(NewSpotUuidEvent(spotUuid: value)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            key: const Key("btn_join_spot"),
            child: const Text("Join spot"),
            onPressed: () => context
                .read<JoinSpotPageBloc>()
                .add(JoinSpotEvent(spotUuid: spotUuid)),
          ),
        ),
      ],
    );
  }
}

class _QrCodeView extends StatelessWidget {
  final String error;

  const _QrCodeView({
    required this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        error.isNotEmpty
            ? Text(
                error,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).colorScheme.error),
              )
            : Container(),
        QRView(
          key: const Key("qr_code_scanner"),
          onQRViewCreated: (controller) => context
              .read<JoinSpotPageBloc>()
              .add(QrCodeScannerInitedEvent(controller: controller)),
        )
      ],
    );
  }
}
