import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/features/home_page/network_switcher_widget.dart';
import 'package:open_transit_app/features/home_page/theme_switcher_widget.dart';
import 'package:open_transit_app/features/network_selection/current_network_provider.dart';
import 'package:open_transit_app/utils/misc_providers.dart';
import 'package:open_transit_app/utils/utils.dart';
import 'package:open_transit_app/utils/web_utils/web_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/link.dart';

part 'home_page.g.dart';

@riverpod
Uri? apkDownloadUrl(ApkDownloadUrlRef ref) {
  // TODO: resolve this
  return null;
  // Non-null only on Web
  return WebUtils.instance
      ?.getBaseUrl()
      ?.resolve('downloads/open-transit-dev.apk');
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final androidAppLink = _buildAndroidAppLink(context, ref);

    final filledButtonTheme = FilledButtonThemeData(
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
    );

    return FilledButtonTheme(
      data: filledButtonTheme,
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
          child: const Text('Blank Button'),
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
