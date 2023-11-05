import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/features/network_selection/current_network_provider.dart';
import 'package:open_transit_app/features/networks/network_provider.dart';

class LocationSwitcher extends ConsumerWidget {
  const LocationSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networksAsync = ref.watch(transitNetworksProvider);
    const fixedWidth = 240.0;

    return switch (networksAsync) {
      AsyncData(value: final networks) => AlertDialog(
          icon: const Icon(Icons.location_city_rounded),
          title: const Text('Select your location'),
          elevation: 8,
          content: SizedBox(
            // TODO: dynamic width
            width: fixedWidth,
            child: ListView.builder(
              primary: true,
              shrinkWrap: true,
              itemCount: networks.length,
              itemBuilder: (BuildContext context, int index) {
                final network = networks[index];
                return ListTile(
                  title: Text(network.name),
                  onTap: () {
                    ref
                        .read(currentTransitNetworkProvider.notifier)
                        .change(context, network.id);
                  },
                );
              },
            ),
          ),
        ),
      AsyncError(:final error) => ErrorDialog(text: error.toString()),
      _ => AlertDialog(
          icon: const Icon(Icons.location_city_rounded),
          title: const SizedBox(
            width: fixedWidth,
            child: Text('Loading available locations...'),
          ),
          elevation: 8,
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: fixedWidth,
              maxHeight: 200,
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
    };
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Error'),
      elevation: 8,
      backgroundColor: theme.colorScheme.error,
      titleTextStyle: theme.textTheme.titleLarge!
          .copyWith(color: theme.colorScheme.onError),
      contentTextStyle: theme.textTheme.titleMedium!
          .copyWith(color: theme.colorScheme.onError),
      content: Text(text),
    );
  }
}
