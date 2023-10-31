// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transitNetworkRepositoryHash() =>
    r'97e96c442f432b64ac38c8c076815160ce7641be';

/// See also [transitNetworkRepository].
@ProviderFor(transitNetworkRepository)
final transitNetworkRepositoryProvider =
    Provider<TransitNetworkRepository>.internal(
  transitNetworkRepository,
  name: r'transitNetworkRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transitNetworkRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransitNetworkRepositoryRef = ProviderRef<TransitNetworkRepository>;
String _$transitNetworksHash() => r'05e921a08618f06508cbed6409f93fc05da63610';

/// See also [TransitNetworks].
@ProviderFor(TransitNetworks)
final transitNetworksProvider =
    AsyncNotifierProvider<TransitNetworks, List<TransitNetwork>>.internal(
  TransitNetworks.new,
  name: r'transitNetworksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transitNetworksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransitNetworks = AsyncNotifier<List<TransitNetwork>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
