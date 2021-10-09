abstract class SettingsPageEvent {}

class InitEvent implements SettingsPageEvent {}

class ChangeUseOsThemeEvent implements SettingsPageEvent {
  final bool value;

  ChangeUseOsThemeEvent({required this.value});
}
