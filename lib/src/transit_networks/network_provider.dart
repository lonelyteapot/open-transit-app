import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'mock_network_repo.dart';
import 'network_model.dart';
import 'network_repo.dart';

part 'network_provider.g.dart';

@riverpod
TransitNetworkRepository transitNetworkRepository(
  TransitNetworkRepositoryRef ref,
) {
  return const MockTransitNetworkRepository();
}

@riverpod
class TransitNetworks extends _$TransitNetworks {
  @override
  FutureOr<List<TransitNetwork>> build() async {
    final networkRepository = ref.watch(transitNetworkRepositoryProvider);
    return await networkRepository.getAllNetworks();
  }
}
