import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes_repository.dart';

part 'routes_cubit_state.dart';

class TransitRoutesCubit extends Cubit<TransitRoutesState> {
  TransitRoutesCubit({
    required this.transitRoutesRepository,
  }) : super(TransitRoutesInitial());

  final TransitRoutesRepository transitRoutesRepository;

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
