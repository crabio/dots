// External
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dots_client/api/connector.dart';
import 'package:dots_client/settings/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart' as log;

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
import 'package:dots_client/utils/bloc_middleware.dart';
import 'package:dots_client/pages/main/page.dart';
import 'package:dots_client/settings/settings.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  log.Logger.root.level = log.Level.FINER;
  log.Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  Bloc.observer = BlocObserverLogMiddleware();

  final appSettingsController = AppSettingsController();
  await appSettingsController.init();

  runApp(App(appSettingsController: appSettingsController));
}

class App extends StatelessWidget {
  final AppSettingsController appSettingsController;

  const App({required this.appSettingsController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppSettingsController>(
            create: (context) => appSettingsController),
        RepositoryProvider<GeolocatorPlatform>(
            create: (context) => GeolocatorPlatform.instance),
        RepositoryProvider<SpotServiceConnector>(
            create: (context) => SpotServiceConnector(
                appSettingsController: appSettingsController)),
      ],
      child: AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: appSettingsController.settings.themeMode,
        builder: (theme, darkTheme) => MaterialApp(
          title: 'Dots App',
          theme: theme,
          darkTheme: darkTheme,
          home: MainPage(),
        ),
      ),
    );
  }
}
