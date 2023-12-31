import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/layout/layout_orientation_provider.dart';
import 'package:open_transit_app/layout/main_layout.dart';
import 'package:open_transit_app/utils/misc_providers.dart';

class MainPageWrapper extends ConsumerWidget {
  const MainPageWrapper({
    super.key,
    this.child = const SizedBox(),
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = ref.watch(layoutOrientationProvider);

    final borderRadius = (orientation == Orientation.portrait)
        ? kSlidingPanelBorderRadius
        : null;
    final padding = (orientation == Orientation.portrait)
        ? const EdgeInsets.only(top: 16.0)
        : const EdgeInsets.all(0.0);

    return PrimaryScrollController(
      controller: ref.watch(primaryScrollControllerProvider),
      automaticallyInheritForPlatforms: TargetPlatform.values.toSet(),
      child: Material(
        borderRadius: borderRadius,
        child: SafeArea(
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
