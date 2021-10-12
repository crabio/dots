// External
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dots_client/bloc_middleware.dart';
import 'package:dots_client/pages/main/page.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart' as log;

// Internal
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
