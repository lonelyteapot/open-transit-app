import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import 'routes_provider.dart';
import 'routes_repository.dart';

class RoutesView extends ConsumerWidget {
  const RoutesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transitRoutes = ref.watch(transitRoutesProvider);
    return Container(
      padding: const EdgeInsets.only(top: 12),
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
                return _RouteTile(route: routes[index]);
              },
            ),
          AsyncError(:final error) => Center(child: Text('Error: $error')),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _RouteTile extends StatelessWidget {
  const _RouteTile({
    required this.route,
  });

  final TransitRoute route;

  void handlePress() {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: handlePress,
      leading: FilledButton.tonal(
        onPressed: handlePress,
        child: ConstrainedBox(
          // TODO: Dynamic synced width
          constraints: const BoxConstraints(minWidth: 56),
          child: Text(
            route.number,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontFamily: 'monospace',
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      title: Text(
        route.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.directions_bus),
    );
  }
}
