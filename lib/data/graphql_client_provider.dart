import 'package:graphql/client.dart';
import 'package:open_transit_app/features/settings/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graphql_client_provider.g.dart';

@Riverpod(keepAlive: true)
GraphQLClient graphqlClient(GraphqlClientRef ref) {
  final graphqlEndpointUrl = ref.watch(
    settingsProvider.select((s) => s.graphqlEndpointUrl),
  );
  if (graphqlEndpointUrl.isEmpty) {
    throw Exception(
      'GraphQL endpoint URL is not configured. Set it or enable "Use mock data".',
    );
  }

  final link = HttpLink(graphqlEndpointUrl);

  final client = GraphQLClient(
    cache: GraphQLCache(), // in-memory cache
    link: link,
  );

  return client;
}
