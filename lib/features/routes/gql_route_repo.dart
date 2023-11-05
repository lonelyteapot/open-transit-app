import 'dart:async';

import 'package:graphql/client.dart';
import 'package:open_transit_app/features/routes/route_model.dart';
import 'package:open_transit_app/features/routes/route_repo.dart';
import 'package:open_transit_app/utils/utils.dart';

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
