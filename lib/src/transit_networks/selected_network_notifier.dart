import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network.dart';

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
  SelectedNetworkNotifier.new,
);
