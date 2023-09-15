import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/main_screen/map_widget.dart';
import 'package:open_transit_app/settings.dart';
import 'package:open_transit_app/utils.dart';
import 'package:open_transit_app/web_utils/web_utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/link.dart';

final _apkDownloadUrl =
    WebUtils.instance?.getBaseUrl()?.resolve('open-transit-app.apk');

class MainScreen extends ConsumerWidget {
  const MainScreen({
    super.key,
  });

  bool _shouldShowAndroidAppDownloadLink() {
    return _apkDownloadUrl != null &&
        defaultTargetPlatform != TargetPlatform.iOS;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Theme.of(context).isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawerScrimColor: Colors.black38,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_shouldShowAndroidAppDownloadLink())
                _AndroidAppDownloadLink(url: _apkDownloadUrl),
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
      body: Builder(
        builder: (context) {
          return SlidingUpPanel(
            minHeight: 160,
            maxHeight: MediaQuery.sizeOf(context).height -
                MediaQuery.paddingOf(context).top,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
            backdropEnabled: true,
            backdropOpacity: 0,
            color: Theme.of(context).colorScheme.background,
            panel: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: const SafeArea(
                child: Center(
                  child: FlutterLogo(),
                ),
              ),
            ),
            body: const CustomMapWidget(),
          );
        },
      ),
    );
  }
}

class _AndroidAppDownloadLink extends StatelessWidget {
  const _AndroidAppDownloadLink({
    required this.url,
  });

  final Uri? url;

  Widget? _buildSubtitle() {
    assert(kIsWeb);
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const Text('for smoother experience');
    }
    return const Text('to monitor on the go');
  }

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: url,
      target: LinkTarget.self,
      builder: (context, followLink) {
        return ListTile(
          title: const Text('Download Android app'),
          subtitle: _buildSubtitle(),
          leading: const Icon(Icons.system_update),
          onTap: followLink,
        );
      },
    );
  }
}
