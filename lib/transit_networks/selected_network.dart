import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/transit_networks/networks.dart';

class SelectedNetworkNotifier extends AsyncNotifier<TransitNetwork?> {
  @override
  FutureOr<TransitNetwork?> build() {
    return null;
  }

  void select(TransitNetwork? network) {
    state = AsyncValue.data(network);
  }
}

final selectedNetworkProvider =
    AsyncNotifierProvider<SelectedNetworkNotifier, TransitNetwork?>(
        SelectedNetworkNotifier.new);
