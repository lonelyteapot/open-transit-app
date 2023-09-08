import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class SettingsData {
  const SettingsData({required this.themeMode});

  final ThemeMode themeMode;
}

class SettingsNotifier extends Notifier<SettingsData> {
  @override
  SettingsData build() {
    return const SettingsData(
      themeMode: ThemeMode.system,
    );
  }

  void updateThemeMode(final ThemeMode value) {
    state = SettingsData(themeMode: value);
  }
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsData>(SettingsNotifier.new);
