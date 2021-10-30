import 'package:dots_client/pages/settings/form.dart';
import 'package:dots_client/settings/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form.dart';
import 'bloc/bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsPageBloc(
        appSettingsController:
            RepositoryProvider.of<AppSettingsController>(context),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: const SettingsForm(),
      ),
    );
  }
}
