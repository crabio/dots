// External
import 'package:dots_client/pages/settings/form.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'form.dart';
import 'bloc/bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsPageBloc(
        settings: RepositoryProvider.of<AppSettings>(context),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Dots')),
        body: const SettingsForm(),
      ),
    );
  }
}
