import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings.dart';

@immutable
class SettingsRepository {
  const SettingsRepository({required SharedPreferences sharedPreferences})
      : prefs = sharedPreferences;

  final SharedPreferences prefs;

  SettingsData load() {
    final themeMode = prefs.get('themeMode') ?? 'system';
    final showDebugInfo = prefs.getBool('showDebugInfo') ?? false;
    final useCancellableTileProvider =
        prefs.getBool('useCancellableTileProvider') ?? true;
    return SettingsData(
      themeMode: ThemeMode.values.firstWhere(
        (element) => element.name == themeMode,
      ),
      showDebugInfo: showDebugInfo,
      useCancellableTileProvider: useCancellableTileProvider,
    );
  }

  Future<void> save(final SettingsData settings) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString('themeMode', settings.themeMode.name),
      prefs.setBool('showDebugInfo', settings.showDebugInfo),
      prefs.setBool(
        'useCancellableTileProvider',
        settings.useCancellableTileProvider,
      ),
    ]);
  }
}
