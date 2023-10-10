import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/shared_preferences.dart';
import 'settings.dart';
import 'settings_repository.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  late final SettingsRepository _settingsService;

  @override
  SettingsData build() {
    _settingsService = SettingsRepository(
      sharedPreferences: ref.watch(sharedPreferencesProvider),
    );
    return _settingsService.load();
  }

  void setThemeMode(final ThemeMode value) {
    state = state.copyWith(themeMode: value);
    unawaited(_settingsService.save(state));
  }

  void setShowDebugInfo(final bool value) {
    state = state.copyWith(showDebugInfo: value);
    unawaited(_settingsService.save(state));
  }

  void setUseCancellableTileProvider(final bool value) {
    state = state.copyWith(useCancellableTileProvider: value);
    unawaited(_settingsService.save(state));
  }
}
