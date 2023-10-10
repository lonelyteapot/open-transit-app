import 'dart:async';

import 'route_model.dart';

abstract class TransitRouteRepository {
  TransitRouteRepository({
    required this.networkId,
  });

  final String networkId;

  FutureOr<List<TransitRoute>> getAllRoutes();
}
