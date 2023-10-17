import 'dart:async';

import 'network_model.dart';

abstract class TransitNetworkRepository {
  FutureOr<List<TransitNetwork>> getNetworks();
}
