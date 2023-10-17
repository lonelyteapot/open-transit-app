import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';

@freezed
class SettingsData with _$SettingsData {
  const factory SettingsData({
    required ThemeMode themeMode,
    required bool showDebugInfo,
    required bool useCancellableTileProvider,
    required bool useMockData,
    required String graphqlEndpointUrl,
  }) = _SettingsData;
}
