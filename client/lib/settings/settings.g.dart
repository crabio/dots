// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AppSettingsCopyWith on AppSettings {
  AppSettings copyWith({
    Environment? environment,
    bool? ligthTheme,
    bool? useOsThemeSettings,
  }) {
    return AppSettings(
      environment: environment ?? this.environment,
      ligthTheme: ligthTheme ?? this.ligthTheme,
      useOsThemeSettings: useOsThemeSettings ?? this.useOsThemeSettings,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => AppSettings(
      useOsThemeSettings: json['useOsThemeSettings'] as bool? ?? true,
      ligthTheme: json['ligthTheme'] as bool? ?? true,
      environment: json['environment'] == null
          ? const Environment(
              name: "localhost", host: "localhost", port: 8080, secure: false)
          : Environment.fromJson(json['environment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'useOsThemeSettings': instance.useOsThemeSettings,
      'ligthTheme': instance.ligthTheme,
      'environment': instance.environment,
    };

Environment _$EnvironmentFromJson(Map<String, dynamic> json) => Environment(
      name: json['name'] as String,
      host: json['host'] as String,
      port: json['port'] as int,
      secure: json['secure'] as bool,
    );

Map<String, dynamic> _$EnvironmentToJson(Environment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'host': instance.host,
      'port': instance.port,
      'secure': instance.secure,
    };
