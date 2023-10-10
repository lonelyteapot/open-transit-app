import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network.freezed.dart';

@freezed
class TransitNetwork with _$TransitNetwork {
  const factory TransitNetwork({
    required String id,
    required String name,
    Decimal? centerLat,
    Decimal? centerLon,
  }) = _TransitNetwork;
}
