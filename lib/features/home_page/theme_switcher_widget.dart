import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/settings_provider.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider).themeMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SegmentedButton<ThemeMode>(
        showSelectedIcon: false,
        selected: {themeMode},
        onSelectionChanged: (value) {
          final settingsNotifier = ref.read(settingsProvider.notifier);
          settingsNotifier.modifyAndSave(
            (oldSettings) => oldSettings.copyWith(themeMode: value.single),
          );
        },
        style: const ButtonStyle(
          iconSize: MaterialStatePropertyAll(28.0),
          side: MaterialStatePropertyAll(BorderSide.none),
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
          visualDensity: VisualDensity.standard,
        ),
        segments: [
          ButtonSegment(
            value: ThemeMode.light,
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.light_mode_outlined,
            ),
            tooltip: 'Switch to light theme',
          ),
          ButtonSegment(
            value: ThemeMode.system,
            icon: Icon(
              themeMode == ThemeMode.system
                  ? Icons.brightness_auto
                  : Icons.brightness_auto_outlined,
            ),
            tooltip: 'Switch to system-defined theme',
          ),
          ButtonSegment(
            value: ThemeMode.dark,
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.dark_mode_outlined,
            ),
            tooltip: 'Switch to dark theme',
          ),
        ],
      ),
    );
  }
}
