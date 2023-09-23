import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'routes_repository.dart';

part 'routes_provider.g.dart';

@riverpod
TransitRoutesRepository transitRoutesRepository(
  TransitRoutesRepositoryRef ref,
) {
  return TransitRoutesRepository();
}

@riverpod
FutureOr<List<TransitRoute>> transitRoutes(TransitRoutesRef ref) async {
  final transitRoutesRepository = ref.watch(transitRoutesRepositoryProvider);
  return await transitRoutesRepository.fetchRoutes();
}
