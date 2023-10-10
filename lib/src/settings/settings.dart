import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
class SettingsData with _$SettingsData {
  const factory SettingsData({
    required ThemeMode themeMode,
    required bool showDebugInfo,
    required bool useCancellableTileProvider,
  }) = _SettingsData;
}
