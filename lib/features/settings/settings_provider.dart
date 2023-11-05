import 'dart:async';

import 'package:open_transit_app/data/shared_preferences_provider.dart';
import 'package:open_transit_app/features/settings/settings_model.dart';
import 'package:open_transit_app/features/settings/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
