import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_model.dart';

@immutable
class SettingsRepository {
  const SettingsRepository({required SharedPreferences sharedPreferences})
      : prefs = sharedPreferences;

  final SharedPreferences prefs;

  Future<void> save(final SettingsData settings) async {
    final json = settings.toJson();

    await Future.forEach(json.entries, (e) async {
      await _saveEntry(e.key, e.value);
    });
  }

  SettingsData load() {
    final json = defaultSettings.toJson();

    for (final key in json.keys) {
      final value = prefs.get(key);
      if (value != null) {
        json[key] = value;
      }
    }

    return SettingsData.fromJson(json);
  }

  Future<void> _saveEntry(final String key, final dynamic value) async {
    switch (value) {
      case bool value:
        await prefs.setBool(key, value);
        break;
      case int value:
        await prefs.setInt(key, value);
        break;
      case double value:
        await prefs.setDouble(key, value);
        break;
      case String value:
        await prefs.setString(key, value);
        break;
      case List<String> value:
        await prefs.setStringList(key, value);
        break;
      default:
        throw UnimplementedError('Unsupported SharedPreferences value type');
    }
  }
}
