import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/src/transit_networks/network_data.dart';

class SelectedNetworkNotifier extends AsyncNotifier<TransitNetwork?> {
  @override
  FutureOr<TransitNetwork?> build() {
    return null;
  }

  void select(TransitNetwork? network) {
    state = AsyncValue.data(network);
  }
}

final pSelectedTransitNetwork =
    AsyncNotifierProvider<SelectedNetworkNotifier, TransitNetwork?>(
        SelectedNetworkNotifier.new);
