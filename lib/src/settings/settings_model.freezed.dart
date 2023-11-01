// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SettingsData _$SettingsDataFromJson(Map<String, dynamic> json) {
  return _SettingsData.fromJson(json);
}

/// @nodoc
mixin _$SettingsData {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  bool get showDebugInfo => throw _privateConstructorUsedError;
  bool get useCancellableTileProvider => throw _privateConstructorUsedError;
  bool get useMockData => throw _privateConstructorUsedError;
  String get graphqlEndpointUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsDataCopyWith<SettingsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsDataCopyWith<$Res> {
  factory $SettingsDataCopyWith(
          SettingsData value, $Res Function(SettingsData) then) =
      _$SettingsDataCopyWithImpl<$Res, SettingsData>;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool showDebugInfo,
      bool useCancellableTileProvider,
      bool useMockData,
      String graphqlEndpointUrl});
}

/// @nodoc
class _$SettingsDataCopyWithImpl<$Res, $Val extends SettingsData>
    implements $SettingsDataCopyWith<$Res> {
  _$SettingsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? showDebugInfo = null,
    Object? useCancellableTileProvider = null,
    Object? useMockData = null,
    Object? graphqlEndpointUrl = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      showDebugInfo: null == showDebugInfo
          ? _value.showDebugInfo
          : showDebugInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      useCancellableTileProvider: null == useCancellableTileProvider
          ? _value.useCancellableTileProvider
          : useCancellableTileProvider // ignore: cast_nullable_to_non_nullable
              as bool,
      useMockData: null == useMockData
          ? _value.useMockData
          : useMockData // ignore: cast_nullable_to_non_nullable
              as bool,
      graphqlEndpointUrl: null == graphqlEndpointUrl
          ? _value.graphqlEndpointUrl
          : graphqlEndpointUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsDataImplCopyWith<$Res>
    implements $SettingsDataCopyWith<$Res> {
  factory _$$SettingsDataImplCopyWith(
          _$SettingsDataImpl value, $Res Function(_$SettingsDataImpl) then) =
      __$$SettingsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool showDebugInfo,
      bool useCancellableTileProvider,
      bool useMockData,
      String graphqlEndpointUrl});
}

/// @nodoc
class __$$SettingsDataImplCopyWithImpl<$Res>
    extends _$SettingsDataCopyWithImpl<$Res, _$SettingsDataImpl>
    implements _$$SettingsDataImplCopyWith<$Res> {
  __$$SettingsDataImplCopyWithImpl(
      _$SettingsDataImpl _value, $Res Function(_$SettingsDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? showDebugInfo = null,
    Object? useCancellableTileProvider = null,
    Object? useMockData = null,
    Object? graphqlEndpointUrl = null,
  }) {
    return _then(_$SettingsDataImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      showDebugInfo: null == showDebugInfo
          ? _value.showDebugInfo
          : showDebugInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      useCancellableTileProvider: null == useCancellableTileProvider
          ? _value.useCancellableTileProvider
          : useCancellableTileProvider // ignore: cast_nullable_to_non_nullable
              as bool,
      useMockData: null == useMockData
          ? _value.useMockData
          : useMockData // ignore: cast_nullable_to_non_nullable
              as bool,
      graphqlEndpointUrl: null == graphqlEndpointUrl
          ? _value.graphqlEndpointUrl
          : graphqlEndpointUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsDataImpl implements _SettingsData {
  const _$SettingsDataImpl(
      {required this.themeMode,
      required this.showDebugInfo,
      required this.useCancellableTileProvider,
      required this.useMockData,
      required this.graphqlEndpointUrl});

  factory _$SettingsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsDataImplFromJson(json);

  @override
  final ThemeMode themeMode;
  @override
  final bool showDebugInfo;
  @override
  final bool useCancellableTileProvider;
  @override
  final bool useMockData;
  @override
  final String graphqlEndpointUrl;

  @override
  String toString() {
    return 'SettingsData(themeMode: $themeMode, showDebugInfo: $showDebugInfo, useCancellableTileProvider: $useCancellableTileProvider, useMockData: $useMockData, graphqlEndpointUrl: $graphqlEndpointUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsDataImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.showDebugInfo, showDebugInfo) ||
                other.showDebugInfo == showDebugInfo) &&
            (identical(other.useCancellableTileProvider,
                    useCancellableTileProvider) ||
                other.useCancellableTileProvider ==
                    useCancellableTileProvider) &&
            (identical(other.useMockData, useMockData) ||
                other.useMockData == useMockData) &&
            (identical(other.graphqlEndpointUrl, graphqlEndpointUrl) ||
                other.graphqlEndpointUrl == graphqlEndpointUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode, showDebugInfo,
      useCancellableTileProvider, useMockData, graphqlEndpointUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsDataImplCopyWith<_$SettingsDataImpl> get copyWith =>
      __$$SettingsDataImplCopyWithImpl<_$SettingsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsDataImplToJson(
      this,
    );
  }
}

abstract class _SettingsData implements SettingsData {
  const factory _SettingsData(
      {required final ThemeMode themeMode,
      required final bool showDebugInfo,
      required final bool useCancellableTileProvider,
      required final bool useMockData,
      required final String graphqlEndpointUrl}) = _$SettingsDataImpl;

  factory _SettingsData.fromJson(Map<String, dynamic> json) =
      _$SettingsDataImpl.fromJson;

  @override
  ThemeMode get themeMode;
  @override
  bool get showDebugInfo;
  @override
  bool get useCancellableTileProvider;
  @override
  bool get useMockData;
  @override
  String get graphqlEndpointUrl;
  @override
  @JsonKey(ignore: true)
  _$$SettingsDataImplCopyWith<_$SettingsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
