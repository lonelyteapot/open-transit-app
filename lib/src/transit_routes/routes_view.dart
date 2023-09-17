import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class RoutesView extends ConsumerWidget {
  const RoutesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: PrimaryScrollController(
        controller: context.watch<ScrollController>(),
        automaticallyInheritForPlatforms: TargetPlatform.values.toSet(),
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.route),
              title: Text('Route ${index + 1}'),
            );
          },
        ),
      ),
    );
  }
}
