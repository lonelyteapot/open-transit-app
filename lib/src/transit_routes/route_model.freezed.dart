// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransitRoute {
  String get id => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransitRouteCopyWith<TransitRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransitRouteCopyWith<$Res> {
  factory $TransitRouteCopyWith(
          TransitRoute value, $Res Function(TransitRoute) then) =
      _$TransitRouteCopyWithImpl<$Res, TransitRoute>;
  @useResult
  $Res call({String id, String number, String name});
}

/// @nodoc
class _$TransitRouteCopyWithImpl<$Res, $Val extends TransitRoute>
    implements $TransitRouteCopyWith<$Res> {
  _$TransitRouteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransitRouteImplCopyWith<$Res>
    implements $TransitRouteCopyWith<$Res> {
  factory _$$TransitRouteImplCopyWith(
          _$TransitRouteImpl value, $Res Function(_$TransitRouteImpl) then) =
      __$$TransitRouteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String number, String name});
}

/// @nodoc
class __$$TransitRouteImplCopyWithImpl<$Res>
    extends _$TransitRouteCopyWithImpl<$Res, _$TransitRouteImpl>
    implements _$$TransitRouteImplCopyWith<$Res> {
  __$$TransitRouteImplCopyWithImpl(
      _$TransitRouteImpl _value, $Res Function(_$TransitRouteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? name = null,
  }) {
    return _then(_$TransitRouteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransitRouteImpl implements _TransitRoute {
  const _$TransitRouteImpl(
      {required this.id, required this.number, required this.name});

  @override
  final String id;
  @override
  final String number;
  @override
  final String name;

  @override
  String toString() {
    return 'TransitRoute(id: $id, number: $number, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransitRouteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, number, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransitRouteImplCopyWith<_$TransitRouteImpl> get copyWith =>
      __$$TransitRouteImplCopyWithImpl<_$TransitRouteImpl>(this, _$identity);
}

abstract class _TransitRoute implements TransitRoute {
  const factory _TransitRoute(
      {required final String id,
      required final String number,
      required final String name}) = _$TransitRouteImpl;

  @override
  String get id;
  @override
  String get number;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$TransitRouteImplCopyWith<_$TransitRouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
