import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers.dart';
import '../transit_network_selector/current_network_provider.dart';
import 'layout_orientation.dart';
import 'main_layout.dart';

class MainShell extends ConsumerWidget {
  const MainShell({
    super.key,
    required this.body,
    required this.goRouterState,
  });

  final Widget body;
  final GoRouterState goRouterState;

  Widget _buildWithConstraints(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final orientation = constraints.maxWidth > 2 * kSidebarWidth
        ? Orientation.landscape
        : Orientation.portrait;
    return ProviderScope(
      overrides: [
        layoutOrientationProvider.overrideWithValue(orientation),
      ],
      child: MainLayout(orientation: orientation, body: body),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        goRouterStateProvider.overrideWithValue(goRouterState),
      ],
      child: Consumer(
        builder: (context, ref, _) {
          // It's a hack for something, prevents issues from lazy-loading
          ref.listen(currentTransitNetworkProvider, (_, __) {});
          return LayoutBuilder(
            builder: _buildWithConstraints,
          );
        },
      ),
    );
  }
}
