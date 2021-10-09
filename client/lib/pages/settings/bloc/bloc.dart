// External
import 'dart:convert';

import 'package:dots_client/settings/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Internal
import 'events.dart';
import 'state.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  SettingsPageBloc() : super(InitingState()) {
    on<InitEvent>(
      (event, emit) async {
        final prefs = await SharedPreferences.getInstance();
        final settingsStr = prefs.getString(AppSettings.sharedPreferencesKey);

        // Check that settings exists
        if (settingsStr == null) {
          // Settings are not exist
          final defaultSettings = AppSettings();
          prefs.setString(
            AppSettings.sharedPreferencesKey,
            jsonEncode(defaultSettings.toJson()),
          );
          emit(InitedState(settings: defaultSettings));
        } else {
          // Setings exist
          final settings = AppSettings.fromJson(jsonDecode(settingsStr));
          emit(InitedState(settings: settings));
        }
      },
    );

    add(InitEvent());
  }
}
