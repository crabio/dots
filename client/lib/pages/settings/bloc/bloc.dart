// External
import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:dots_client/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Internal
import 'events.dart';
import 'state.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  SettingsPageBloc({required AppSettings settings})
      : super(InitedState(settings: settings)) {
    on<ChangeUseOsThemeEvent>((event, emit) async {
      final curState = state;
      if (curState is InitedState) {
        final newSettings = curState.settings.copyWith(
          useOsThemeSettings: event.value,
        );
        if (!await newSettings.save()) {
          throw Exception("Couldn't save settings");
        }
        event.value
            ? AdaptiveTheme.of(event.context).setSystem()
            : curState.settings.ligthTheme
                ? AdaptiveTheme.of(event.context).setLight()
                : AdaptiveTheme.of(event.context).setDark();
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
        if (!await newSettings.save()) {
          throw Exception("Couldn't save settings");
        }
        event.value
            ? AdaptiveTheme.of(event.context).setLight()
            : AdaptiveTheme.of(event.context).setDark();
        emit(InitedState(settings: newSettings));
      } else {
        throw Exception("Wrong state $state for $event");
      }
    });
    on<ChangeEnvironmentEvent>((event, emit) async {
      final curState = state;
      if (curState is InitedState) {
        final newSettings = curState.settings.copyWith(
          environment:
              EnvironmentType.values.elementAt(event.index).toEnvironment(),
        );
        if (!await newSettings.save()) {
          throw Exception("Couldn't save settings");
        }
        emit(InitedState(settings: newSettings));
      } else {
        throw Exception("Wrong state $state for $event");
      }
    });
  }
}