import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/map_widget.dart';
import 'package:open_transit_app/settings.dart';
import 'package:open_transit_app/utils.dart';

class MainView extends ConsumerWidget {
  const MainView({
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
              context.isDarkMode ? Brightness.light : Brightness.dark,
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
              const Center(child: Text('Theme')),
              Padding(
                padding: const EdgeInsets.all(16).copyWith(top: 4),
                child: SegmentedButton<ThemeMode>(
                  showSelectedIcon: false,
                  selected: {ref.watch(settingsProvider).themeMode},
                  onSelectionChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .updateThemeMode(value.single);
                  },
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('Light'),
                    ),
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text('System'),
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
