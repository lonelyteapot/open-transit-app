import 'package:open_transit_app/data/graphql_client_provider.dart';
import 'package:open_transit_app/features/network_selection/current_network_provider.dart';
import 'package:open_transit_app/features/routes/gql_route_repo.dart';
import 'package:open_transit_app/features/routes/mock_route_repo.dart';
import 'package:open_transit_app/features/routes/route_model.dart';
import 'package:open_transit_app/features/routes/route_repo.dart';
import 'package:open_transit_app/features/settings/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
