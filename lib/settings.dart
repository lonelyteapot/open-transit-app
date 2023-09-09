import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class SettingsNotifier extends Notifier<SettingsData> {
  @override
  SettingsData build() {
    return const SettingsData(
      themeMode: ThemeMode.system,
      showDebugInfo: false,
    );
  }

  void setThemeMode(final ThemeMode value) {
    state = state.copyWith(themeMode: value);
  }

  void setShowDebugInfo(final bool value) {
    state = state.copyWith(showDebugInfo: value);
  }
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsData>(SettingsNotifier.new);
