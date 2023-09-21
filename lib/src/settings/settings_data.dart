import 'package:flutter/material.dart';

@immutable
class SettingsData {
  const SettingsData({
    required this.themeMode,
    required this.showDebugInfo,
  });

  final ThemeMode themeMode;
  final bool showDebugInfo;

  SettingsData copyWith({
    ThemeMode? themeMode,
    bool? showDebugInfo,
  }) {
    return SettingsData(
      themeMode: themeMode ?? this.themeMode,
      showDebugInfo: showDebugInfo ?? this.showDebugInfo,
    );
  }
}
