// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transitRoutesRepositoryHash() =>
    r'04825a2c3806615665f6fcfdc85cd8acdf245d5b';

/// See also [transitRoutesRepository].
@ProviderFor(transitRoutesRepository)
final transitRoutesRepositoryProvider =
    AutoDisposeProvider<TransitRoutesRepository>.internal(
  transitRoutesRepository,
  name: r'transitRoutesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transitRoutesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransitRoutesRepositoryRef
    = AutoDisposeProviderRef<TransitRoutesRepository>;
String _$transitRoutesHash() => r'04b56901139f5bf0360ef231014f97bd2bdfc593';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
