import 'package:flutter/material.dart';

abstract class SettingsPageEvent {}

class ChangeUseOsThemeEvent implements SettingsPageEvent {
  final BuildContext context;
  final bool value;

  ChangeUseOsThemeEvent({required this.context, required this.value});
}

class ChangeLightThemeEvent implements SettingsPageEvent {
  final BuildContext context;
  final bool value;

  ChangeLightThemeEvent({required this.context, required this.value});
}

class ChangeEnvironmentEvent implements SettingsPageEvent {
  final int index;

  ChangeEnvironmentEvent({required this.index});
}
