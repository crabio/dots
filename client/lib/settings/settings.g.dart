// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AppSettingsCopyWith on AppSettings {
  AppSettings copyWith({
    bool? ligthTheme,
    bool? useOsThemeSettings,
  }) {
    return AppSettings(
      ligthTheme: ligthTheme ?? this.ligthTheme,
      useOsThemeSettings: useOsThemeSettings ?? this.useOsThemeSettings,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return AppSettings(
    useOsThemeSettings: json['useOsThemeSettings'] as bool,
    ligthTheme: json['ligthTheme'] as bool,
  );
}

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'useOsThemeSettings': instance.useOsThemeSettings,
      'ligthTheme': instance.ligthTheme,
    };
