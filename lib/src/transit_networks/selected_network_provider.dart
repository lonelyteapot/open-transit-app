import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'network.dart';

part 'selected_network_provider.g.dart';

@riverpod
class SelectedTransitNetwork extends _$SelectedTransitNetwork {
  @override
  FutureOr<TransitNetwork?> build() {
    return null;
  }

  void select(TransitNetwork? network) {
    state = AsyncValue.data(network);
  }
}
