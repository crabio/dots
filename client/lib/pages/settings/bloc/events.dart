import 'package:flutter/material.dart';

abstract class SettingsPageEvent {}

class ChangeUseOsThemeEvent extends SettingsPageEvent {
  final BuildContext context;
  final bool value;

  ChangeUseOsThemeEvent({required this.context, required this.value});
}

class ChangeLightThemeEvent extends SettingsPageEvent {
  final BuildContext context;
  final bool value;

  ChangeLightThemeEvent({required this.context, required this.value});
}

class ChangeEnvironmentEvent extends SettingsPageEvent {
  final int index;

  ChangeEnvironmentEvent({required this.index});
}
