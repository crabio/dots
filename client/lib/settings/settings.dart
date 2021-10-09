// External
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

// Internal
part 'settings.g.dart';

@JsonSerializable()
@CopyWith()
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
