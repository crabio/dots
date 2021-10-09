// External
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'package:dots_client/theme.dart';
import 'form.dart';
import 'bloc/bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainPageBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Dots')),
        body: const MainForm(),
      ),
    );
  }
}
