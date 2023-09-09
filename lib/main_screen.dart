import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/map_widget.dart';
import 'package:open_transit_app/settings.dart';
import 'package:open_transit_app/utils.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Theme.of(context).isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ListTile(
                title: Text('Open Transit'),
              ),
              const Spacer(),
              SwitchListTile(
                title: const Text('Debug info'),
                value: ref.watch(settingsProvider).showDebugInfo,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).setShowDebugInfo(value);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Center(child: Text('Theme')),
              ),
              Padding(
                padding: const EdgeInsets.all(16).copyWith(top: 0),
                child: SegmentedButton<ThemeMode>(
                  showSelectedIcon: false,
                  selected: {ref.watch(settingsProvider).themeMode},
                  onSelectionChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setThemeMode(value.single);
                  },
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('Light'),
                    ),
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text('Auto'),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text('Dark'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: const CustomMapWidget(),
    );
  }
}
