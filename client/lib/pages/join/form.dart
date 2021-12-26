import 'package:dots_client/pages/lobby/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'bloc/bloc.dart';

class JoinSpotForm extends StatelessWidget {
  final String playerUuid;

  final _logger = Logger("JoinSpotForm");

  JoinSpotForm({
    required this.playerUuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinSpotPageBloc, JoinSpotPageState>(
      builder: (context, state) {
        _logger.fine("state $state");
        if (state is JoinSpotPageInitial) {
          return _InitialView(
            spotUuid: state.spotUuid,
            error: state.error,
            success: state.success,
          );
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
  final bool success;

  const _InitialView({
    required this.spotUuid,
    required this.error,
    required this.success,
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
                  Icons.text_fields,
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
            child: TabBarView(
              children: [
                _TextInputView(
                  spotUuid: spotUuid,
                  error: error,
                ),
                _QrCodeScannerView(
                  error: error,
                  success: success,
                ),
              ],
            ),
          ),
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

class _QrCodeScannerView extends StatefulWidget {
  final String error;
  final bool success;

  const _QrCodeScannerView({
    required this.error,
    required this.success,
    Key? key,
  }) : super(key: key);

  @override
  __QrCodeScannerViewState createState() => __QrCodeScannerViewState();
}

class __QrCodeScannerViewState extends State<_QrCodeScannerView> {
  // TODO Init controller once on page open and after this just get controller
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Center(
            child: (widget.error.isNotEmpty)
                ? Text(
                    widget.error,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).colorScheme.error),
                  )
                : const Text('Scan a spot code'),
          ),
        ),
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: QRView(
              key: GlobalKey(debugLabel: 'qr_code_scanner'),
              onQRViewCreated: (controller) {
                controller = controller;
                context
                    .read<JoinSpotPageBloc>()
                    .add(QrCodeScannerInitedEvent(controller: controller));
              },
              overlay: QrScannerOverlayShape(
                  borderColor: widget.success ? Colors.green : Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
