import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/graphql.dart';
import '../settings/settings_provider.dart';
import 'gql_network_repo.dart';
import 'mock_network_repo.dart';
import 'network_model.dart';
import 'network_repo.dart';

part 'network_provider.g.dart';

@Riverpod(keepAlive: true)
TransitNetworkRepository transitNetworkRepository(
  TransitNetworkRepositoryRef ref,
) {
  final useMockData = ref.watch(settingsProvider.select((s) => s.useMockData));
  if (useMockData) {
    return const MockTransitNetworkRepository();
  } else {
    final graphqlClient = ref.watch(graphqlClientProvider);
    return GQLTransitNetworkRepository(client: graphqlClient);
  }
}

@Riverpod(keepAlive: true)
class TransitNetworks extends _$TransitNetworks {
  @override
  FutureOr<List<TransitNetwork>> build() async {
    final networkRepository = ref.watch(transitNetworkRepositoryProvider);
    return await networkRepository.getNetworks();
  }
}
