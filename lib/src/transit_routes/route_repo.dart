import 'dart:async';

import 'route_model.dart';

abstract class TransitRouteRepository {
  FutureOr<List<TransitRoute>> getAllRoutesForNetwork(final String networkId);
}
