import 'dart:async';

import 'package:decimal/decimal.dart';

import 'package:open_transit_app/features/networks/network_model.dart';
import 'package:open_transit_app/features/networks/network_repo.dart';

class MockTransitNetworkRepository implements TransitNetworkRepository {
  const MockTransitNetworkRepository();

  @override
  FutureOr<List<TransitNetwork>> getNetworks() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      TransitNetwork(
        id: 'b2e8c9dd-0cf5-41f1-9b6b-b54e400c626f',
        name: 'Nizhny Novgorod',
        centerLat: Decimal.parse('56.284700'),
        centerLon: Decimal.parse('44.007500'),
      ),
      const TransitNetwork(
        id: 'cc7a7157-18bf-45d0-bb72-51e3cb171714',
        name: 'Tokyo',
      ),
      const TransitNetwork(
        id: '4228a543-9fbe-4a1c-90a4-5dc4d1e884d7',
        name: 'Shanghai',
      ),
      TransitNetwork(
        id: '4effbd9c-0195-42d8-8e05-75d9e640d7fd',
        name: 'Beijing',
        centerLat: Decimal.parse('39.906667'),
        centerLon: Decimal.parse('116.397500'),
      ),
      TransitNetwork(
        id: 'ff51f59b-0bec-4e29-95a7-d25de7024eec',
        name: 'Moscow',
        centerLat: Decimal.parse('55.755833'),
        centerLon: Decimal.parse('37.617222'),
      ),
      TransitNetwork(
        id: 'c7af2254-87b7-492d-aa1f-4d04a6aee2b4',
        name: 'Munich',
        centerLat: Decimal.parse('48.137500'),
        centerLon: Decimal.parse('11.575000'),
      ),
    ];
  }
}
