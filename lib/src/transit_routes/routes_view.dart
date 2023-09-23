import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import 'routes_provider.dart';

class RoutesView extends ConsumerWidget {
  const RoutesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transitRoutes = ref.watch(transitRoutesProvider);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: PrimaryScrollController(
        controller: ref.watch(primaryScrollControllerProvider),
        automaticallyInheritForPlatforms: TargetPlatform.values.toSet(),
        child: switch (transitRoutes) {
          AsyncData(value: final routes) => ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                final route = routes[index];
                return ListTile(
                  leading: const Icon(Icons.route),
                  title: Text(route.name),
                );
              },
            ),
          AsyncError(:final error) => Center(child: Text('Error: $error')),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
