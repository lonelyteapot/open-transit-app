import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../transit_networks/network_provider.dart';
import 'selected_network_provider.dart';

class LocationSwitcher extends ConsumerWidget {
  LocationSwitcher({super.key});

  // TODO: Dispose, or remove altogether
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wrappedNetworks = ref.watch(transitNetworksProvider);
    final wrappedSelectedNetwork = ref.watch(selectedTransitNetworkProvider);

    final label = switch (wrappedNetworks) {
      AsyncData() => 'Location',
      AsyncError(:final error) => error.toString(),
      _ => 'Loading...',
    };

    return AlertDialog(
      title: const Text('Choose your location'),
      elevation: 8,
      content: DropdownMenu<String?>(
        enabled: wrappedNetworks.hasValue,
        leadingIcon: const Icon(Icons.location_city),
        initialSelection: wrappedSelectedNetwork.valueOrNull?.id,
        controller: textEditingController,
        // TODO: Rework when DropdownMenu gets expandedInsets property
        width: 232,
        label: Text(label),
        dropdownMenuEntries: wrappedNetworks.maybeWhen(
          data: (data) => data.map(
            (network) {
              return DropdownMenuEntry(
                value: network.id,
                label: network.name,
              );
            },
          ).toList(),
          orElse: List.empty,
        ),
        onSelected: (final String? networkId) {
          ref.read(selectedTransitNetworkProvider.notifier).select(networkId);
        },
      ),
    );
  }
}
