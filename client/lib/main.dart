// External
import 'package:adaptive_theme/adaptive_theme.dart';
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

  log.Logger.root.level = log.Level.FINE;
  log.Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  Bloc.observer = BlocObserverLogMiddleware();

  final settings = await AppSettings.read();

  runApp(App(settings: settings));
}

class App extends StatelessWidget {
  final AppSettings settings;

  const App({required this.settings, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppSettings>(create: (context) => settings),
        RepositoryProvider<GeolocatorPlatform>(
            create: (context) => GeolocatorPlatform.instance),
        RepositoryProvider<proto.SpotServiceClient>(
            create: (context) => proto.SpotServiceClient(
                  ClientChannel(
                    settings.environment.host,
                    port: settings.environment.port,
                    options: const ChannelOptions(
                      credentials: ChannelCredentials.insecure(),
                    ),
                  ),
                )),
      ],
      child: AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: settings.themeMode,
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
