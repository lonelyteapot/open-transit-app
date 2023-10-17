// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transitRouteRepositoryHash() =>
    r'dacc1ad67e1adc5665d969d99fa93796e9d2d7d6';

/// See also [transitRouteRepository].
@ProviderFor(transitRouteRepository)
final transitRouteRepositoryProvider =
    AutoDisposeProvider<TransitRouteRepository>.internal(
  transitRouteRepository,
  name: r'transitRouteRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transitRouteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransitRouteRepositoryRef
    = AutoDisposeProviderRef<TransitRouteRepository>;
String _$transitRoutesHash() => r'e8b98bd557d873f2c9a7a0c973ec7e5437cb5f0c';

/// See also [transitRoutes].
@ProviderFor(transitRoutes)
final transitRoutesProvider =
    AutoDisposeFutureProvider<List<TransitRoute>>.internal(
  transitRoutes,
  name: r'transitRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transitRoutesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransitRoutesRef = AutoDisposeFutureProviderRef<List<TransitRoute>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter
