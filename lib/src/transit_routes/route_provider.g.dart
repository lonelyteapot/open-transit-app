// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transitRouteRepositoryHash() =>
    r'39981efb006c6595dbfa669c30c7db94c915aef7';

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
String _$transitRoutesHash() => r'6a2234d2673e3a5bfbe2328a1ceb0b4d3d48bd76';

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
