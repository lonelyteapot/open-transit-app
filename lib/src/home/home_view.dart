import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/link.dart';

import '../core/providers.dart';
import '../core/utils.dart';
import '../transit_network_selector/current_network_provider.dart';
import '../web_utils/web_utils.dart';
import 'network_switcher.dart';
import 'theme_switcher.dart';

part 'home_view.g.dart';

@riverpod
Uri? apkDownloadUrl(ApkDownloadUrlRef ref) {
  // Non-null only on Web
  return WebUtils.instance?.getBaseUrl()?.resolve('open-transit.apk');
}

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final androidAppLink = _buildAndroidAppLink(context, ref);
    return SafeArea(
      child: Material(
        child: FilledButtonTheme(
          data: FilledButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopButtons(context, ref),
              const SizedBox(height: 16),
              if (androidAppLink != null) androidAppLink,
              const Spacer(),
              const ThemeSwitcher(),
              const NetworkSwitcher(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButtons(BuildContext context, WidgetRef ref) {
    final isNetworkSelected =
        ref.watch(currentTransitNetworkProvider).valueOrNull != null;
    return GridView.count(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.none,
      children: [
        FilledButton.tonal(
          onPressed: !isNetworkSelected
              ? null
              : () {
                  unawaited(
                    ref
                        .read(slidingPanelControllerProvider)
                        ?.animatePanelToPosition(
                          1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        ),
                  );
                  context.goRelative('routes');
                },
          child: const Text('Routes'),
        ),
        FilledButton.tonal(
          onPressed: !isNetworkSelected ? null : () {},
          child: const Text('(blank)'),
        ),
        FilledButton.tonal(
          onPressed: !isNetworkSelected ? null : () {},
          child: const Text('(blank)'),
        ),
        FilledButton.tonal(
          onPressed: !isNetworkSelected ? null : () {},
          child: const Text('(blank)'),
        ),
      ],
    );
  }

  Widget? _buildAndroidAppLink(BuildContext context, WidgetRef ref) {
    final apkUrl = ref.watch(apkDownloadUrlProvider);
    if (apkUrl == null) {
      return null;
    }
    final subtitle = switch (defaultTargetPlatform) {
      TargetPlatform.android => 'to have smoother experience',
      _ => 'to monitor on the go',
    };
    return Link(
      uri: apkUrl,
      target: LinkTarget.self,
      builder: (context, followLink) {
        return ListTile(
          title: const Text('Get the Android app'),
          subtitle: Text(subtitle),
          leading: const Icon(Icons.system_update),
          onTap: followLink,
        );
      },
    );
  }
}
