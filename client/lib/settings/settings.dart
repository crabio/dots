// External
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Internal
part 'settings.g.dart';

@JsonSerializable()
@CopyWith()
class AppSettings {
  static const sharedPreferencesKey = "dots_settings";
  final bool useOsThemeSettings;
  final bool ligthTheme;

  final Environment environment;

  AppSettings({
    this.useOsThemeSettings = true,
    this.ligthTheme = true,
    this.environment = const Environment(
      name: "localhost",
      host: "localhost",
      port: 8080,
      secure: false,
    ),
  });

  /// Method reads settings from shared preferences or creates default config
  static Future<AppSettings> read() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsStr = prefs.getString(AppSettings.sharedPreferencesKey);

    // Check that settings exists
    if (settingsStr == null) {
      // Settings are not exist
      final defaultSettings = AppSettings();
      if (!await update(prefs, defaultSettings)) {
        throw Exception("Couldn't save settings");
      }
      return defaultSettings;
    } else {
      // Setings exist
      try {
        final settings = AppSettings.fromJson(jsonDecode(settingsStr));
        return settings;
      } catch (ex) {
        // Save default settings
        final defaultSettings = AppSettings();
        if (!await update(prefs, defaultSettings)) {
          throw Exception("Couldn't save settings");
        }
        return defaultSettings;
      }
    }
  }

  static Future<bool> update(
    SharedPreferences prefs,
    AppSettings settings,
  ) async {
    return await prefs.setString(
      AppSettings.sharedPreferencesKey,
      jsonEncode(settings.toJson()),
    );
  }

  Future<bool> save() async {
    final prefs = await SharedPreferences.getInstance();
    return await update(prefs, this);
  }

  // JSON methods
  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}

@JsonSerializable()
class Environment {
  final String name;
  final String host;
  final int port;
  final bool secure;

  const Environment({
    required this.name,
    required this.host,
    required this.port,
    required this.secure,
  });

  // JSON methods
  factory Environment.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);
  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);
}

enum EnvironmentType {
  localhost,

  androidLocalhost,
}

extension EnvironmentTypeConv on EnvironmentType {
  Environment toEnvironment() {
    final valueMap = <EnvironmentType, Environment>{
      EnvironmentType.localhost: const Environment(
        name: "localhost",
        host: "localhost",
        port: 8080,
        secure: false,
      ),
      EnvironmentType.androidLocalhost: const Environment(
        name: "androidLocalhost",
        host: "10.0.2.2",
        port: 8080,
        secure: false,
      ),
    };
    return valueMap[this]!;
  }
}
