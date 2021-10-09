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
  final Environment environment;

  AppSettings({
    this.useOsThemeSettings = true,
    this.ligthTheme = true,
    this.environment = Environment.localhost,
  });

  // JSON methods
  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}

enum Environment {
  @JsonValue("localhost")
  localhost,

  @JsonValue("androidLocalhost")
  androidLocalhost,
}

extension EnvironmentToString on Environment {
  String toShortString() {
    return toString().split(".").last;
  }

  String toAddress() {
    final valueMap = <Environment, String>{
      Environment.localhost: "http://localhost:8080",
      Environment.androidLocalhost: "http://10.0.2.2:8080",
    };
    return valueMap[this]!;
  }
}
