import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../core/utils.dart';
import '../transit_network_selector/current_network_provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: FilledButtonTheme(
        data: FilledButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        child: Builder(
          builder: (context) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopButtons(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TopButtons extends ConsumerWidget {
  const TopButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNetworkSelected =
        ref.watch(currentTransitNetworkProvider).valueOrNull != null;
    return GridView.count(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.5,
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
          style: FilledButtonTheme.of(context).style!.copyWith(
                shape: _createRoundedCornerShape(base: 8, topLeft: 16),
              ),
          child: const Text('Routes'),
        ),
        FilledButton.tonal(
          onPressed: !isNetworkSelected ? null : () {},
          child: const Text('(blank)'),
        ),
        FilledButton.tonal(
          onPressed: !isNetworkSelected ? null : () {},
          style: FilledButtonTheme.of(context).style!.copyWith(
                shape: _createRoundedCornerShape(base: 8, topRight: 16),
              ),
          child: const Text('(blank)'),
        ),
      ],
    );
  }
}

MaterialStateProperty<OutlinedBorder?> _createRoundedCornerShape({
  required double base,
  double? topLeft,
  double? topRight,
  double? bottomLeft,
  double? bottomRight,
}) {
  return MaterialStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(base)).copyWith(
        topLeft: topLeft != null ? Radius.circular(topLeft) : null,
        topRight: topRight != null ? Radius.circular(topRight) : null,
        bottomLeft: bottomLeft != null ? Radius.circular(bottomLeft) : null,
        bottomRight: bottomRight != null ? Radius.circular(bottomRight) : null,
      ),
    ),
  );
}
