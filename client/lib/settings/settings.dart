// External
import 'package:json_annotation/json_annotation.dart';

// Internal
part 'settings.g.dart';

@JsonSerializable()
class AppSettings {
  static const sharedPreferencesKey = "dots_settings";
  final bool useOsThemeSettings;
  final bool ligthTheme;

  AppSettings({
    this.useOsThemeSettings = true,
    this.ligthTheme = true,
  });

  // JSON methods
  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}
