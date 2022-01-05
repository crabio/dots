import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dots_client/api/connector.dart';
import 'package:dots_client/settings/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart' as log;
import 'package:dots_client/utils/bloc_middleware.dart';
import 'package:dots_client/pages/main/page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  log.Logger.root.level = log.Level.FINER;
  log.Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final appSettingsController = AppSettingsController();
  await appSettingsController.init();

  // Request permissions
  if (await Permission.camera.request().isDenied) {
    // TODO Add instruction
    throw Exception("Camera permission is not granded");
  }
  if (await Permission.location.request().isDenied) {
    // TODO Add instruction
    throw Exception("Location permission is not granded");
  }

  BlocOverrides.runZoned(
    () => runApp(App(appSettingsController: appSettingsController)),
    blocObserver: BlocObserverLogMiddleware(),
  );
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
