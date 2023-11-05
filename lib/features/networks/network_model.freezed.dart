// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransitNetwork {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Decimal? get centerLat => throw _privateConstructorUsedError;
  Decimal? get centerLon => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransitNetworkCopyWith<TransitNetwork> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransitNetworkCopyWith<$Res> {
  factory $TransitNetworkCopyWith(
          TransitNetwork value, $Res Function(TransitNetwork) then) =
      _$TransitNetworkCopyWithImpl<$Res, TransitNetwork>;
  @useResult
  $Res call({String id, String name, Decimal? centerLat, Decimal? centerLon});
}

/// @nodoc
class _$TransitNetworkCopyWithImpl<$Res, $Val extends TransitNetwork>
    implements $TransitNetworkCopyWith<$Res> {
  _$TransitNetworkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? centerLat = freezed,
    Object? centerLon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      centerLat: freezed == centerLat
          ? _value.centerLat
          : centerLat // ignore: cast_nullable_to_non_nullable
              as Decimal?,
      centerLon: freezed == centerLon
          ? _value.centerLon
          : centerLon // ignore: cast_nullable_to_non_nullable
              as Decimal?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransitNetworkImplCopyWith<$Res>
    implements $TransitNetworkCopyWith<$Res> {
  factory _$$TransitNetworkImplCopyWith(_$TransitNetworkImpl value,
          $Res Function(_$TransitNetworkImpl) then) =
      __$$TransitNetworkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, Decimal? centerLat, Decimal? centerLon});
}

/// @nodoc
class __$$TransitNetworkImplCopyWithImpl<$Res>
    extends _$TransitNetworkCopyWithImpl<$Res, _$TransitNetworkImpl>
    implements _$$TransitNetworkImplCopyWith<$Res> {
  __$$TransitNetworkImplCopyWithImpl(
      _$TransitNetworkImpl _value, $Res Function(_$TransitNetworkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? centerLat = freezed,
    Object? centerLon = freezed,
  }) {
    return _then(_$TransitNetworkImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      centerLat: freezed == centerLat
          ? _value.centerLat
          : centerLat // ignore: cast_nullable_to_non_nullable
              as Decimal?,
      centerLon: freezed == centerLon
          ? _value.centerLon
          : centerLon // ignore: cast_nullable_to_non_nullable
              as Decimal?,
    ));
  }
}

/// @nodoc

class _$TransitNetworkImpl implements _TransitNetwork {
  const _$TransitNetworkImpl(
      {required this.id, required this.name, this.centerLat, this.centerLon});

  @override
  final String id;
  @override
  final String name;
  @override
  final Decimal? centerLat;
  @override
  final Decimal? centerLon;

  @override
  String toString() {
    return 'TransitNetwork(id: $id, name: $name, centerLat: $centerLat, centerLon: $centerLon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransitNetworkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.centerLat, centerLat) ||
                other.centerLat == centerLat) &&
            (identical(other.centerLon, centerLon) ||
                other.centerLon == centerLon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, centerLat, centerLon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransitNetworkImplCopyWith<_$TransitNetworkImpl> get copyWith =>
      __$$TransitNetworkImplCopyWithImpl<_$TransitNetworkImpl>(
          this, _$identity);
}

abstract class _TransitNetwork implements TransitNetwork {
  const factory _TransitNetwork(
      {required final String id,
      required final String name,
      final Decimal? centerLat,
      final Decimal? centerLon}) = _$TransitNetworkImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  Decimal? get centerLat;
  @override
  Decimal? get centerLon;
  @override
  @JsonKey(ignore: true)
  _$$TransitNetworkImplCopyWith<_$TransitNetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
