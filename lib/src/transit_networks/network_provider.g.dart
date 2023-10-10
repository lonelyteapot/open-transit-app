// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transitNetworkRepositoryHash() =>
    r'e193f2ad577522e3e81140238cfdb38f2ad5ff16';

/// See also [transitNetworkRepository].
@ProviderFor(transitNetworkRepository)
final transitNetworkRepositoryProvider =
    AutoDisposeProvider<TransitNetworkRepository>.internal(
  transitNetworkRepository,
  name: r'transitNetworkRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transitNetworkRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransitNetworkRepositoryRef
    = AutoDisposeProviderRef<TransitNetworkRepository>;
String _$transitNetworksHash() => r'fe02f807ec1e5dffae3df480161e7d31ba9a4db6';

/// See also [TransitNetworks].
@ProviderFor(TransitNetworks)
final transitNetworksProvider = AutoDisposeAsyncNotifierProvider<
    TransitNetworks, List<TransitNetwork>>.internal(
  TransitNetworks.new,
  name: r'transitNetworksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transitNetworksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransitNetworks = AutoDisposeAsyncNotifier<List<TransitNetwork>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter
