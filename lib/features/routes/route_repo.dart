import 'dart:async';

import 'package:open_transit_app/features/routes/route_model.dart';

abstract class TransitRouteRepository {
  FutureOr<List<TransitRoute>> getAllRoutesForNetwork(final String networkId);
}
