import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:graphql/client.dart';

import '../../utils/utils.dart';
import 'network_model.dart';
import 'network_repo.dart';

final gqlGetNetworks = gql(r'''
  query GetNetworks {
    networks {
      edges {
        node {
          id
          name
        }
      }
    }
  }
''');

class GQLTransitNetworkRepository implements TransitNetworkRepository {
  const GQLTransitNetworkRepository({required this.client});

  final GraphQLClient client;

  @override
  FutureOr<List<TransitNetwork>> getNetworks() async {
    final result = await client.query(
      QueryOptions(
        document: gqlGetNetworks,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    final networks = result.data!['networks']['edges'] as List;
    return networks.mapToList(
      (json) => TransitNetwork(
        id: json['node']['id'],
        name: json['node']['name'],
        centerLat: json['node']['centerLat'] != null
            ? Decimal.parse(json['node']['centerLat'] as String)
            : null,
        centerLon: json['node']['centerLon'] != null
            ? Decimal.parse(json['node']['centerLon'] as String)
            : null,
      ),
    );
  }
}
