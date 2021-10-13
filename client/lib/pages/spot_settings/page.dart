// External
import 'package:dots_client/pages/main/page.dart';
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:dots_client/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

// Internal
import 'form.dart';
import 'bloc/bloc.dart';

class SpotSettingsPage extends StatelessWidget {
  final LatLng userPosition;

  const SpotSettingsPage({
    required this.userPosition,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpotSettingsPageBloc(
        appSettings: RepositoryProvider.of<AppSettings>(context),
        position: userPosition,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dots'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => navPopAndPush(context, const MainPage()),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: SpotSettingsForm(),
      ),
    );
  }
}
