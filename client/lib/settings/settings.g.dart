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

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return AppSettings(
    useOsThemeSettings: json['useOsThemeSettings'] as bool,
    ligthTheme: json['ligthTheme'] as bool,
    environment: _$enumDecode(_$EnvironmentEnumMap, json['environment']),
  );
}

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'useOsThemeSettings': instance.useOsThemeSettings,
      'ligthTheme': instance.ligthTheme,
      'environment': _$EnvironmentEnumMap[instance.environment],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$EnvironmentEnumMap = {
  Environment.localhost: 'localhost',
  Environment.androidLocalhost: 'androidLocalhost',
};
