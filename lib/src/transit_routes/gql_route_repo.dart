import 'dart:async';

import 'package:graphql/client.dart';

import '../core/utils.dart';
import 'route_model.dart';
import 'route_repo.dart';

final gqlGetRoutesForNetwork = gql(r'''
  query GetRoutesForNetwork($networkId: UUID!) {
    networkById(id: $networkId) {
      routes {
        edges {
          node {
            id
            number
            name
          }
        }
      }
    }
  }
''');

class GQLTransitRouteRepository implements TransitRouteRepository {
  const GQLTransitRouteRepository({required this.client});

  final GraphQLClient client;

  @override
  FutureOr<List<TransitRoute>> getAllRoutesForNetwork(
    final String networkId,
  ) async {
    final result = await client.query(
      QueryOptions(
        document: gqlGetRoutesForNetwork,
        variables: {
          'networkId': networkId,
        },
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    final routes = result.data!['networkById']['routes']['edges'] as List;

    return routes.mapToList(
      (json) => TransitRoute(
        id: json['node']['id']! as String,
        number: json['node']['number']! as String,
        name: json['node']['name']! as String,
      ),
    );
  }
}
