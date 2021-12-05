import 'package:dots_client/pages/lobby/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state.error.isNotEmpty
                  ? Text(
                      state.error,
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
                      .add(JoinSpotEvent(spotUuid: state.spotUuid)),
                ),
              ),
            ],
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
