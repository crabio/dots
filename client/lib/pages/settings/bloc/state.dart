// Internal
import 'package:dots_client/settings/settings.dart';

abstract class SettingsPageState {}

// Initial page state
class InitingState implements SettingsPageState {}

// When settings are loaded
class InitedState implements SettingsPageState {
  final AppSettings settings;

  InitedState({required this.settings});
}
