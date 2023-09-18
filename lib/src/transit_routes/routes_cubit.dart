import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_transit_app/src/transit_routes/routes_repository.dart';

part 'routes_cubit_state.dart';

class TransitRoutesCubit extends Cubit<TransitRoutesState> {
  final TransitRoutesRepository transitRoutesRepository;

  TransitRoutesCubit({
    required this.transitRoutesRepository,
  }) : super(TransitRoutesInitial());

  Future<void> loadRoutes() async {
    emit(TransitRoutesLoading());
    try {
      final routes = await transitRoutesRepository.fetchRoutes();
      emit(TransitRoutesLoaded(routes: routes));
    } catch (e) {
      emit(TransitRoutesError(e));
    }
  }
}
