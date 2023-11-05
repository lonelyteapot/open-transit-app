import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/data/constants.dart';
import 'package:open_transit_app/features/settings/settings_provider.dart';
import 'package:open_transit_app/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_page.g.dart';

@Riverpod(keepAlive: true)
FutureOr<PackageInfo> packageInfo(PackageInfoRef ref) async {
  return PackageInfo.fromPlatform();
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Developer Settings',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SwitchListTile(
          title: const Text('Show debugging info'),
          value: ref.watch(settingsProvider).showDebugInfo,
          onChanged: (value) {
            final settingsNotifier = ref.read(settingsProvider.notifier);
            settingsNotifier.modifyAndSave(
              (oldSettings) => oldSettings.copyWith(showDebugInfo: value),
            );
          },
        ),
        SwitchListTile(
          title: const Text('Cancel map requests'),
          value: ref.watch(settingsProvider).useCancellableTileProvider,
          onChanged: (value) {
            final settingsNotifier = ref.read(settingsProvider.notifier);
            settingsNotifier.modifyAndSave(
              (oldSettings) => oldSettings.copyWith(
                useCancellableTileProvider: value,
              ),
            );
            _showSnackBar(
              context,
              'Move the map to unload old tiles for changes to take effect',
            );
          },
        ),
        SwitchListTile(
          title: const Text('Use mock data'),
          value: ref.watch(settingsProvider).useMockData,
          onChanged: (value) {
            final settingsNotifier = ref.read(settingsProvider.notifier);
            settingsNotifier.modifyAndSave(
              (oldSettings) => oldSettings.copyWith(useMockData: value),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            enabled: !ref.watch(settingsProvider).useMockData,
            controller: TextEditingController(
              text: ref.watch(settingsProvider).graphqlEndpointUrl,
            ),
            decoration: const InputDecoration(
              labelText: 'GraphQL endpoint url',
              hintText: 'http://127.0.0.1/graphql',
            ),
            keyboardType: TextInputType.url,
            onSubmitted: (value) {
              final settingsNotifier = ref.read(settingsProvider.notifier);
              settingsNotifier.modifyAndSave(
                (oldSettings) => oldSettings.copyWith(
                  graphqlEndpointUrl: value,
                ),
              );
            },
          ),
        ),
        const Spacer(),
        const _AppInfo(),
      ],
    );
  }
}

class _AppInfo extends ConsumerWidget {
  const _AppInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final version = packageInfo.valueOrNull?.version;
    final platform =
        kIsWeb ? 'Web' : defaultTargetPlatform.name.toCapitalized();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Visibility(
        visible: packageInfo.valueOrNull != null,
        child: SelectableText(
          '$kAppNameBase v$version ($kAppBuildFlavor Build) for $platform',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 8),
    ),
  );
}
