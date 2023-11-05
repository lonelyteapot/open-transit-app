import 'package:open_transit_app/features/map/ot_map_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ot_map_controller_provider.g.dart';

@riverpod
OtMapController otMapController(OtMapControllerRef ref) {
  return OtMapController();
}
