import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsData with _$SettingsData {
  const factory SettingsData({
    required ThemeMode themeMode,
    required bool showDebugInfo,
    required bool useCancellableTileProvider,
    required bool useMockData,
    required String graphqlEndpointUrl,
  }) = _SettingsData;

  factory SettingsData.fromJson(Map<String, Object?> json) =>
      _$SettingsDataFromJson(json);
}

const SettingsData defaultSettings = SettingsData(
  themeMode: ThemeMode.system,
  showDebugInfo: false,
  useCancellableTileProvider: true,
  useMockData: true,
  graphqlEndpointUrl: '',
);
