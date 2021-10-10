// External
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'form.dart';
import 'bloc/bloc.dart';

class MainPage extends StatelessWidget {
  final AppSettings settings;

  const MainPage({required this.settings, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainPageBloc(settings: settings),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dots'),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SettingsPage(settings: settings)),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: MainForm(),
      ),
    );
  }
}
