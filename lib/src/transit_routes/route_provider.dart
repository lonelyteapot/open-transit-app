import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/graphql.dart';
import '../settings/settings_provider.dart';
import '../transit_network_selector/current_network_provider.dart';
import 'gql_route_repo.dart';
import 'mock_route_repo.dart';
import 'route_model.dart';
import 'route_repo.dart';

part 'route_provider.g.dart';

@riverpod
TransitRouteRepository transitRouteRepository(
  TransitRouteRepositoryRef ref,
) {
  final useMockData = ref.watch(settingsProvider.select((s) => s.useMockData));
  if (useMockData) {
    return const MockTransitRouteRepository();
  } else {
    final graphqlClient = ref.watch(graphqlClientProvider);
    return GQLTransitRouteRepository(client: graphqlClient);
  }
}

@Riverpod(dependencies: [transitRouteRepository, CurrentTransitNetwork])
FutureOr<List<TransitRoute>> transitRoutes(TransitRoutesRef ref) async {
  final transitRoutesRepository = ref.watch(transitRouteRepositoryProvider);
  final currentNetwork = ref.watch(currentTransitNetworkProvider);
  final networkId = currentNetwork.value!.id;
  return await transitRoutesRepository.getAllRoutesForNetwork(networkId);
}
