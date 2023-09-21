import 'package:flutter/material.dart';
import 'package:open_transit_app/src/settings/settings_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class SettingsRepository {
  final SharedPreferences prefs;

  const SettingsRepository({required SharedPreferences sharedPreferences})
      : prefs = sharedPreferences;

  SettingsData load() {
    final themeMode = prefs.get('themeMode') ?? 'system';
    final showDebugInfo = prefs.getBool('showDebugInfo') ?? false;
    return SettingsData(
      themeMode: ThemeMode.values.firstWhere(
        (element) => element.name == themeMode,
      ),
      showDebugInfo: showDebugInfo,
    );
  }

  Future<void> save(final SettingsData settings) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString('themeMode', settings.themeMode.name),
      prefs.setBool('showDebugInfo', settings.showDebugInfo),
    ]);
  }
}
