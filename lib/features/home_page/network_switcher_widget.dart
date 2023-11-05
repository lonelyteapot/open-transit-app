import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:open_transit_app/features/network_selection/current_network_provider.dart';

class NetworkSwitcher extends ConsumerStatefulWidget {
  const NetworkSwitcher({super.key});

  @override
  ConsumerState<NetworkSwitcher> createState() => _NetworkSwitcherState();
}

class _NetworkSwitcherState extends ConsumerState<NetworkSwitcher> {
  void handlePress() {
    Scaffold.of(context).closeEndDrawer();
    ref.read(currentTransitNetworkProvider.notifier).change(context, null);
  }

  @override
  Widget build(BuildContext context) {
    final currentNetworkAsync = ref.watch(currentTransitNetworkProvider);
    final network = currentNetworkAsync.valueOrNull;
    if (network != null) {
      return ListTile(
        leading: const Icon(Icons.location_city_rounded),
        title: Text(network.name),
        trailing: TextButton(
          onPressed: handlePress,
          child: const Text('Switch'),
        ),
      );
    }
    if (currentNetworkAsync.hasValue) {
      return ListTile(
        onTap: handlePress,
        leading: const Icon(Icons.location_city_rounded),
        title: TextButton(
          onPressed: handlePress,
          child: const Text('Select your location'),
        ),
      );
    }
    return const LinearProgressIndicator();
  }
}
