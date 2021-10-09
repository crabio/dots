// External
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'package:dots_client/pages/main/bloc/events.dart';
import 'package:dots_client/pages/main/bloc/bloc.dart';
import 'package:dots_client/theme.dart';
import 'package:dots_client/pages/main/bloc/state.dart';

class MainForm extends StatelessWidget {
  const MainForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<MainPageBloc, MainPageState>(
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
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.brightness_6),
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }
}
