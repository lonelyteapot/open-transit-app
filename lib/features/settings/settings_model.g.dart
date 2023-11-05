// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsDataImpl _$$SettingsDataImplFromJson(Map<String, dynamic> json) =>
    _$SettingsDataImpl(
      themeMode: $enumDecode(_$ThemeModeEnumMap, json['themeMode']),
      showDebugInfo: json['showDebugInfo'] as bool,
      useCancellableTileProvider: json['useCancellableTileProvider'] as bool,
      useMockData: json['useMockData'] as bool,
      graphqlEndpointUrl: json['graphqlEndpointUrl'] as String,
    );

Map<String, dynamic> _$$SettingsDataImplToJson(_$SettingsDataImpl instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'showDebugInfo': instance.showDebugInfo,
      'useCancellableTileProvider': instance.useCancellableTileProvider,
      'useMockData': instance.useMockData,
      'graphqlEndpointUrl': instance.graphqlEndpointUrl,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
