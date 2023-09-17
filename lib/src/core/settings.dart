import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  // This should be overridden in main to await the instance before app launch
  throw UnimplementedError();
});

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsData>(SettingsNotifier.new);

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
  late final SettingsService _settingsService;

  @override
  SettingsData build() {
    _settingsService = SettingsService(
      sharedPreferences: ref.watch(sharedPreferencesProvider),
    );
    return _settingsService.loadSettings();
  }

  void setThemeMode(final ThemeMode value) {
    state = state.copyWith(themeMode: value);
    _settingsService.saveSettings(state);
  }

  void setShowDebugInfo(final bool value) {
    state = state.copyWith(showDebugInfo: value);
    _settingsService.saveSettings(state);
  }
}

@immutable
class SettingsService {
  final SharedPreferences prefs;

  const SettingsService({required SharedPreferences sharedPreferences})
      : prefs = sharedPreferences;

  SettingsData loadSettings() {
    final themeMode = prefs.get('themeMode') ?? 'system';
    final showDebugInfo = prefs.getBool('showDebugInfo') ?? false;
    return SettingsData(
      themeMode: ThemeMode.values.firstWhere(
        (element) => element.name == themeMode,
      ),
      showDebugInfo: showDebugInfo,
    );
  }

  Future<void> saveSettings(final SettingsData settings) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString('themeMode', settings.themeMode.name),
      prefs.setBool('showDebugInfo', settings.showDebugInfo),
    ]);
  }
}
