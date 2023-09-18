part of 'routes_cubit.dart';

@immutable
sealed class TransitRoutesState {}

final class TransitRoutesInitial extends TransitRoutesState {}

final class TransitRoutesLoading extends TransitRoutesState {}

final class TransitRoutesError extends TransitRoutesState {
  TransitRoutesError(this.error);

  final Object error;
}

final class TransitRoutesLoaded extends TransitRoutesState {
  TransitRoutesLoaded({required this.routes});

  final List<TransitRoute> routes;
}
