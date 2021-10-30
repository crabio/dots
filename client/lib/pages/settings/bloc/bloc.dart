// External
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dots_client/settings/controller.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'events.dart';
import 'state.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  final AppSettingsController appSettingsController;

  SettingsPageBloc({required this.appSettingsController})
      : super(InitedState(settings: appSettingsController.settings)) {
    on<ChangeUseOsThemeEvent>((event, emit) async {
      final curState = state;
      if (curState is InitedState) {
        final newSettings = curState.settings.copyWith(
          useOsThemeSettings: event.value,
        );
        if (!await appSettingsController.save(newSettings)) {
          throw Exception("Couldn't save settings");
        }
        AdaptiveTheme.of(event.context).setThemeMode(newSettings.themeMode);
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
        if (!await appSettingsController.save(newSettings)) {
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
        if (!await appSettingsController.save(newSettings)) {
          throw Exception("Couldn't save settings");
        }
        emit(InitedState(settings: newSettings));
      } else {
        throw Exception("Wrong state $state for $event");
      }
    });
  }
}
