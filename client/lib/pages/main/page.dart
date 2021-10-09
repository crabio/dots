// External
import 'package:dots_client/pages/settings/page.dart';
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
        appBar: AppBar(
          title: const Text('Dots'),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: const MainForm(),
      ),
    );
  }
}
