import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'network.dart';

part 'networks_provider.g.dart';

@riverpod
class TransitNetworks extends _$TransitNetworks {
  @override
  FutureOr<List<TransitNetwork>> build() async {
    await Future.delayed(const Duration(seconds: 3));
    return [
      const TransitNetwork(
        id: 'cc7a7157-18bf-45d0-bb72-51e3cb171714',
        name: 'Tokyo',
      ),
      const TransitNetwork(
        id: '4228a543-9fbe-4a1c-90a4-5dc4d1e884d7',
        name: 'Shanghai',
      ),
      const TransitNetwork(
        id: '4effbd9c-0195-42d8-8e05-75d9e640d7fd',
        name: 'Beijing',
      ),
      const TransitNetwork(
        id: 'ff51f59b-0bec-4e29-95a7-d25de7024eec',
        name: 'Moscow',
      ),
      const TransitNetwork(
        id: 'c7af2254-87b7-492d-aa1f-4d04a6aee2b4',
        name: 'Munich',
      ),
    ];
  }
}
