// External
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'package:dots_client/pages/main/form.dart';
import 'package:dots_client/theme.dart';
import 'package:dots_client/pages/main/bloc/bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainPageBloc(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Dots')),
          body: const MainForm(),
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
          )),
    );
  }
}
