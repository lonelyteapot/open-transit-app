import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:open_transit_app/features/routes/route_model.dart';
import 'package:open_transit_app/features/routes/route_provider.dart';

class RoutesView extends ConsumerWidget {
  const RoutesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transitRoutes = ref.watch(transitRoutesProvider);
    return switch (transitRoutes) {
      AsyncData(value: final routes) => ListView.builder(
          itemCount: routes.length,
          itemBuilder: (context, index) {
            return _RouteTile(route: routes[index]);
          },
        ),
      AsyncError(:final error) => Center(child: Text('Error: $error')),
      _ => const Center(child: CircularProgressIndicator()),
    };
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
