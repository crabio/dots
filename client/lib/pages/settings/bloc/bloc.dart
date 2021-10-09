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
          if (!await _saveSettings(prefs, defaultSettings)) {
            throw Exception("Couldn't save settings");
          }
          emit(InitedState(settings: defaultSettings));
        } else {
          // Setings exist
          final settings = AppSettings.fromJson(jsonDecode(settingsStr));
          emit(InitedState(settings: settings));
        }
      },
    );
    on<ChangeUseOsThemeEvent>((event, emit) async {
      final curState = state;
      if (curState is InitedState) {
        final newSettings = curState.settings.copyWith(
          useOsThemeSettings: event.value,
        );
        if (!await _updateSettings(newSettings)) {
          throw Exception("Couldn't save settings");
        }
        emit(InitedState(settings: newSettings));
      } else {
        throw Exception("Wrong state $state for $event");
      }
    });
    on<ChangeLightThemeEvent>((event, emit) async {
      final curState = state;
      if (curState is InitedState) {
        final newSettings = curState.settings.copyWith(
          ligthTheme: event.value,
        );
        if (!await _updateSettings(newSettings)) {
          throw Exception("Couldn't save settings");
        }
        emit(InitedState(settings: newSettings));
      } else {
        throw Exception("Wrong state $state for $event");
      }
    });

    add(InitEvent());
  }

  Future<bool> _saveSettings(
      SharedPreferences prefs, AppSettings settings) async {
    return await prefs.setString(
      AppSettings.sharedPreferencesKey,
      jsonEncode(settings.toJson()),
    );
  }

  Future<bool> _updateSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    return _saveSettings(prefs, settings);
  }
}
