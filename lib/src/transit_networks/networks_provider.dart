import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'network.dart';

part 'networks_provider.g.dart';

@riverpod
class TransitNetworks extends _$TransitNetworks {
  @override
  FutureOr<List<TransitNetwork>> build() {
    return [
      const TransitNetwork(
        id: 'tn1',
        name: 'Transit Network 1',
      ),
      const TransitNetwork(
        id: 'tn2',
        name: 'Transit Network 2',
      ),
      const TransitNetwork(
        id: 'tn3',
        name: 'Transit Network 3',
      ),
      const TransitNetwork(
        id: 'tn4',
        name: 'Transit Network 4',
      ),
    ];
  }
}
