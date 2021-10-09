abstract class SettingsPageEvent {}

class InitEvent implements SettingsPageEvent {}

class ChangeUseOsThemeEvent implements SettingsPageEvent {
  final bool value;

  ChangeUseOsThemeEvent({required this.value});
}

class ChangeLightThemeEvent implements SettingsPageEvent {
  final bool value;

  ChangeLightThemeEvent({required this.value});
}

class ChangeEnvironmentEvent implements SettingsPageEvent {
  final int index;

  ChangeEnvironmentEvent({required this.index});
}
