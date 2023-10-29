import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'ot_map_controller.dart';

part 'ot_map_controller_provider.g.dart';

@riverpod
OtMapController otMapController(OtMapControllerRef ref) {
  return OtMapController();
}
