// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network.dart';

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
  $Res call({String id, String name});
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransitNetworkCopyWith<$Res>
    implements $TransitNetworkCopyWith<$Res> {
  factory _$$_TransitNetworkCopyWith(
          _$_TransitNetwork value, $Res Function(_$_TransitNetwork) then) =
      __$$_TransitNetworkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$_TransitNetworkCopyWithImpl<$Res>
    extends _$TransitNetworkCopyWithImpl<$Res, _$_TransitNetwork>
    implements _$$_TransitNetworkCopyWith<$Res> {
  __$$_TransitNetworkCopyWithImpl(
      _$_TransitNetwork _value, $Res Function(_$_TransitNetwork) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_TransitNetwork(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TransitNetwork
    with DiagnosticableTreeMixin
    implements _TransitNetwork {
  const _$_TransitNetwork({required this.id, required this.name});

  @override
  final String id;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TransitNetwork(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TransitNetwork'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransitNetwork &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransitNetworkCopyWith<_$_TransitNetwork> get copyWith =>
      __$$_TransitNetworkCopyWithImpl<_$_TransitNetwork>(this, _$identity);
}

abstract class _TransitNetwork implements TransitNetwork {
  const factory _TransitNetwork(
      {required final String id,
      required final String name}) = _$_TransitNetwork;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_TransitNetworkCopyWith<_$_TransitNetwork> get copyWith =>
      throw _privateConstructorUsedError;
}
