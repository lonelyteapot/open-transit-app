import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes_cubit.dart';

class RoutesView extends ConsumerWidget {
  const RoutesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: PrimaryScrollController(
        controller: context.watch<ScrollController>(),
        automaticallyInheritForPlatforms: TargetPlatform.values.toSet(),
        child: BlocBuilder<TransitRoutesCubit, TransitRoutesState>(
          builder: (context, transitRoutesState) {
            switch (transitRoutesState) {
              case TransitRoutesInitial():
                return const SizedBox();
              case TransitRoutesLoading():
                return const Center(child: CircularProgressIndicator());
              case TransitRoutesError(:final error):
                return Center(child: Text('Error: $error'));
              case TransitRoutesLoaded(:final routes):
                return ListView.builder(
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    final route = routes[index];
                    return ListTile(
                      leading: const Icon(Icons.route),
                      title: Text(route.name),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
