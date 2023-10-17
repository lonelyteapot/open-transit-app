import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/shared_preferences.dart';
import 'settings_model.dart';
import 'settings_repository.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  late final SettingsRepository _settingsService;

  @override
  SettingsData build() {
    _settingsService = SettingsRepository(
      sharedPreferences: ref.watch(sharedPreferencesProvider),
    );
    return _settingsService.load();
  }

  void modifyAndSave(SettingsData Function(SettingsData oldSettings) func) {
    state = func(state);
    unawaited(_settingsService.save(state));
  }
}
