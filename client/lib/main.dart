// External
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dots_client/bloc_middleware.dart';
import 'package:dots_client/pages/main/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

// Internal
import 'theme.dart';

void main() {
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  Bloc.observer = BlocObserverLogMiddleware();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      // TODO Read from settings
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        home: const MainPage(),
      ),
    );
  }
}
