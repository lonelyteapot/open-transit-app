import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_transit_app/features/networks/network_model.dart';
import 'package:open_transit_app/features/networks/network_provider.dart';
import 'package:open_transit_app/utils/misc_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_network_provider.g.dart';

@Riverpod(dependencies: [goRouterState, TransitNetworks], keepAlive: true)
class CurrentTransitNetwork extends _$CurrentTransitNetwork {
  @override
  FutureOr<TransitNetwork?> build() async {
    final pathParameters = ref.watch(goRouterStateProvider).pathParameters;
    final currentNetworkId = pathParameters['network_id'];
    if (currentNetworkId == null) {
      return null;
    }
    final allNetworks = await ref.watch(transitNetworksProvider.future);
    final currentNetwork = allNetworks.firstWhere(
      (network) => network.id == currentNetworkId,
    );
    return currentNetwork;
  }

  void change(BuildContext context, String? networkId) {
    context.go('/${networkId ?? ''}');
  }
}
