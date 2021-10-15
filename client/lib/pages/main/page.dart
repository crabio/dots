// External
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

// Internal
import 'form.dart';
import 'bloc/bloc.dart';

class MainPage extends StatelessWidget {
  final GeolocatorPlatform geolocator;

  const MainPage({
    required this.geolocator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainPageBloc(
        geolocator: geolocator,
        settings: RepositoryProvider.of<AppSettings>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dots'),
          actions: [
            IconButton(
              key: const Key("settings_btn"),
              onPressed: () => navPush(
                context,
                const SettingsPage(),
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
