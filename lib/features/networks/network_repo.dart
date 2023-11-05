import 'dart:async';

import 'package:open_transit_app/features/networks/network_model.dart';

abstract class TransitNetworkRepository {
  FutureOr<List<TransitNetwork>> getNetworks();
}
