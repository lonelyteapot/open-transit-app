import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import 'settings_data.dart';
import 'settings_repository.dart';

class SettingsNotifier extends Notifier<SettingsData> {
  late final SettingsRepository _settingsService;

  @override
  SettingsData build() {
    _settingsService = SettingsRepository(
      sharedPreferences: ref.watch(pSharedPreferences),
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
}

final pSettings =
    NotifierProvider<SettingsNotifier, SettingsData>(SettingsNotifier.new);
