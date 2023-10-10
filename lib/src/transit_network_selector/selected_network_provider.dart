import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../transit_networks/network.dart';
import '../transit_networks/networks_provider.dart';

part 'selected_network_provider.g.dart';

@riverpod
class SelectedTransitNetwork extends _$SelectedTransitNetwork {
  @override
  FutureOr<TransitNetwork?> build() {
    return null;
  }

  void select(String? networkId) {
    if (networkId == null) {
      state = const AsyncValue.data(null);
      return;
    }
    final wrappedNetworks = ref.read(transitNetworksProvider);
    final network = wrappedNetworks.valueOrNull
        ?.firstWhere((network) => network.id == networkId);
    if (network == null) {
      // TODO: Error management
      state = AsyncValue.error('Network not found', StackTrace.current);
      return;
    }
    state = AsyncValue.data(network);
  }
}
