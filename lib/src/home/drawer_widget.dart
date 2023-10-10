import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/link.dart';

import '../core/constants.dart';
import '../core/utils.dart';
import '../settings/settings_provider.dart';
import '../transit_network_selector/selected_network_provider.dart';
import '../transit_networks/network.dart';
import '../web_utils/web_utils.dart';

part 'drawer_widget.g.dart';

@riverpod
Uri? apkDownloadUrl(ApkDownloadUrlRef ref) {
  // Non-null only on Web
  return WebUtils.instance?.getBaseUrl()?.resolve('open-transit-app.apk');
}

@Riverpod(keepAlive: true)
FutureOr<PackageInfo> packageInfo(PackageInfoRef ref) async {
  return PackageInfo.fromPlatform();
}

class DrawerContent extends ConsumerWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apkDownloadUrl = ref.watch(apkDownloadUrlProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _LocationSwitcher(),
        if (apkDownloadUrl != null)
          _AndroidAppDownloadLink(url: apkDownloadUrl),
        const Spacer(),
        SwitchListTile(
          title: const Text('Show debugging info'),
          value: ref.watch(settingsProvider).showDebugInfo,
          onChanged: (value) {
            ref.read(settingsProvider.notifier).setShowDebugInfo(value);
          },
        ),
        const SizedBox(height: 8),
        const _ThemeSelector(),
        const _AppInfo(),
      ],
    );
  }
}

class _LocationSwitcher extends ConsumerStatefulWidget {
  const _LocationSwitcher();

  @override
  ConsumerState<_LocationSwitcher> createState() => _LocationSwitcherState();
}

class _LocationSwitcherState extends ConsumerState<_LocationSwitcher> {
  void handlePress() {
    Scaffold.of(context).closeEndDrawer();
    ref.read(selectedTransitNetworkProvider.notifier).select(null);
  }

  @override
  Widget build(BuildContext context) {
    final selectedNetwork = ref.watch(selectedTransitNetworkProvider);
    return switch (selectedNetwork) {
      AsyncData(value: final TransitNetwork network) => ListTile(
          onTap: handlePress,
          leading: const Icon(Icons.location_city),
          title: Text(network.name),
          trailing: TextButton(
            onPressed: handlePress,
            child: const Text('Change'),
          ),
        ),
      AsyncData(value: final void _) => ListTile(
          onTap: handlePress,
          leading: const Icon(Icons.location_city),
          title: TextButton(
            onPressed: handlePress,
            child: const Text('Choose your location'),
          ),
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _AndroidAppDownloadLink extends StatelessWidget {
  const _AndroidAppDownloadLink({
    required this.url,
  });

  final Uri? url;

  Widget? _buildSubtitle() {
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

class _ThemeSelector extends ConsumerWidget {
  const _ThemeSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider).themeMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SegmentedButton<ThemeMode>(
        showSelectedIcon: false,
        selected: {themeMode},
        onSelectionChanged: (value) {
          ref.read(settingsProvider.notifier).setThemeMode(value.single);
        },
        style: const ButtonStyle(
          iconSize: MaterialStatePropertyAll<double>(24),
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

class _AppInfo extends ConsumerWidget {
  const _AppInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    const appName = kAppNameBase;
    final version = packageInfo.valueOrNull?.version;
    final platform =
        kIsWeb ? 'Web' : defaultTargetPlatform.name.toCapitalized();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Visibility(
        visible: packageInfo.valueOrNull != null,
        child: SelectableText(
          '$appName v$version for $platform',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
