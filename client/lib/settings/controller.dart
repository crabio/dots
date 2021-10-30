import 'package:dots_client/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsController {
  late AppSettings _appSettings;

  get settings => _appSettings;

  Future<void> init() async {
    _appSettings = await AppSettings.read();
  }

  Future<bool> save(AppSettings newSettings) async {
    final prefs = await SharedPreferences.getInstance();
    final ok = await AppSettings.update(prefs, newSettings);
    if (ok) {
      _appSettings = newSettings;
    }
    return ok;
  }
}
