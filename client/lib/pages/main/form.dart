// External
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'bloc/events.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class MainForm extends StatelessWidget {
  const MainForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        if (state is InitedState) {
          return Center(
            child: ElevatedButton(
              key: const Key("btn_create_spot"),
              child: const Text("Create new spot"),
              onPressed: () =>
                  context.read<MainPageBloc>().add(CreateNewSpotEvent()),
            ),
          );
        } else if (state is CreatingNewSpotState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Text("Unkown state: $state");
      },
    );
  }
}
