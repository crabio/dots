// External
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';

// Internal
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/utils/nav.dart';
import 'form.dart';
import 'bloc/bloc.dart';

class SpotPage extends StatelessWidget {
  final String spotUuid;

  const SpotPage({
    required this.spotUuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpotPageBloc(
        channel: RepositoryProvider.of<ClientChannel>(context),
        geolocator: RepositoryProvider.of(context),
        spotUuid: spotUuid,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dots'),
          actions: [
            IconButton(
              onPressed: () => navPush(
                context,
                const SettingsPage(),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: const SpotForm(),
      ),
    );
  }
}
