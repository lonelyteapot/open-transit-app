import 'package:graphql/client.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/graphql_client_provider.dart';
import '../settings/settings_provider.dart';
import 'gql_network_repo.dart';
import 'mock_network_repo.dart';
import 'network_model.dart';
import 'network_repo.dart';

part 'network_provider.g.dart';

@Riverpod(keepAlive: true)
TransitNetworkRepository transitNetworkRepository(
  TransitNetworkRepositoryRef ref,
) {
  final useMockData = ref.watch(settingsProvider.select((s) => s.useMockData));
  if (useMockData) {
    return const MockTransitNetworkRepository();
  } else {
    final graphqlClient = ref.watch(graphqlClientProvider);
    return GQLTransitNetworkRepository(client: graphqlClient);
  }
}

@Riverpod(keepAlive: true)
class TransitNetworks extends _$TransitNetworks {
  @override
  FutureOr<List<TransitNetwork>> build() async {
    final networkRepository = ref.watch(transitNetworkRepositoryProvider);
    try {
      return await networkRepository.getNetworks();
    } on OperationException catch (e) {
      throw CustomException.fromException(e);
    }
  }
}

class CustomException implements Exception {
  CustomException(
    this.message, {
    required this.details,
    this.origin,
  });

  factory CustomException.fromException(Exception exc) {
    if (exc is OperationException) {
      final linkExc = exc.linkException;
      if (linkExc != null) {
        if (linkExc.originalException is ClientException) {
          return CustomException(
            'Failed to get networks from the server',
            details: 'Network request failed\n${linkExc.originalException}',
            origin: exc,
          );
        }
        return CustomException(
          'Failed to get networks from the server',
          details: 'Network request failed\n$linkExc',
          origin: exc,
        );
      }
    }

    return CustomException(
      exc.runtimeType.toString(),
      details: exc.toString(),
      origin: exc,
    );
  }

  final String message;
  final String details;
  final Exception? origin;

  @override
  String toString() {
    return '$message\n\nDetails:\n$details';
  }
}
