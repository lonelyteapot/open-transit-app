import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_model.freezed.dart';

@freezed
class TransitRoute with _$TransitRoute {
  const factory TransitRoute({
    required String id,
    required String number,
    required String name,
  }) = _TransitRoute;
}
