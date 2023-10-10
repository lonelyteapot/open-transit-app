import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'mock_route_repo.dart';
import 'route_model.dart';
import 'route_repo.dart';

part 'route_provider.g.dart';

@riverpod
TransitRouteRepository transitRouteRepository(
  TransitRouteRepositoryRef ref,
) {
  return const MockTransitRouteRepository();
}

@riverpod
FutureOr<List<TransitRoute>> transitRoutes(TransitRoutesRef ref) async {
  final transitRoutesRepository = ref.watch(transitRouteRepositoryProvider);
  return await transitRoutesRepository.getAllRoutes();
}
