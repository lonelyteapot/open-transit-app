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
String _$transitRoutesHash() => r'ad4807f3682838f937bd22d4b34bbb38d784dc41';

/// See also [transitRoutes].
@ProviderFor(transitRoutes)
final transitRoutesProvider =
    AutoDisposeFutureProvider<List<TransitRoute>>.internal(
  transitRoutes,
  name: r'transitRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transitRoutesHash,
  dependencies: <ProviderOrFamily>[
    transitRouteRepositoryProvider,
    currentTransitNetworkProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    transitRouteRepositoryProvider,
    ...?transitRouteRepositoryProvider.allTransitiveDependencies,
    currentTransitNetworkProvider,
    ...?currentTransitNetworkProvider.allTransitiveDependencies
  },
);

typedef TransitRoutesRef = AutoDisposeFutureProviderRef<List<TransitRoute>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
