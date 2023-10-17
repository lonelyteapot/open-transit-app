import 'dart:async';

import 'route_model.dart';
import 'route_repo.dart';

class MockTransitRouteRepository implements TransitRouteRepository {
  const MockTransitRouteRepository();

  @override
  FutureOr<List<TransitRoute>> getAllRoutesForNetwork(
    final String networkId,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      const TransitRoute(
        id: '8d5d61f9-66e4-49f0-aa42-dce7217499f7',
        number: 'A-1',
        name: 'Harmony Sq - Elmwood Ln',
      ),
      const TransitRoute(
        id: 'f9d2439a-7d27-471f-94d0-ec87be5e86f5',
        number: 'A-2',
        name: 'Rosebud Ln - Oak Ave',
      ),
      const TransitRoute(
        id: '5e3d6b5a-15b2-4d4b-a509-80b6a1ecf8f8',
        number: 'T-3',
        name: 'Sunflower Sq - Maple Ave',
      ),
      const TransitRoute(
        id: '7e62d2a7-0b35-4e96-9f52-ef6b7e0a3e4d',
        number: '4',
        name: 'Oak Ave - Magnolia St',
      ),
      const TransitRoute(
        id: '4f9e3d84-1082-4a7f-91ef-573c8f3a07c7',
        number: 'Tl-5',
        name: 'Maple Ave - Serenity Sq',
      ),
    ];
  }
}
