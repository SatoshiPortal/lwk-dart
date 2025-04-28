// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LwkError {
  String get msg;

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LwkErrorCopyWith<LwkError> get copyWith =>
      _$LwkErrorCopyWithImpl<LwkError>(this as LwkError, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LwkError &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @override
  String toString() {
    return 'LwkError(msg: $msg)';
  }
}

/// @nodoc
abstract mixin class $LwkErrorCopyWith<$Res> {
  factory $LwkErrorCopyWith(LwkError value, $Res Function(LwkError) _then) =
      _$LwkErrorCopyWithImpl;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class _$LwkErrorCopyWithImpl<$Res> implements $LwkErrorCopyWith<$Res> {
  _$LwkErrorCopyWithImpl(this._self, this._then);

  final LwkError _self;
  final $Res Function(LwkError) _then;

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_self.copyWith(
      msg: null == msg
          ? _self.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _LwkError implements LwkError {
  const _LwkError({required this.msg});

  @override
  final String msg;

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LwkErrorCopyWith<_LwkError> get copyWith =>
      __$LwkErrorCopyWithImpl<_LwkError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LwkError &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @override
  String toString() {
    return 'LwkError(msg: $msg)';
  }
}

/// @nodoc
abstract mixin class _$LwkErrorCopyWith<$Res>
    implements $LwkErrorCopyWith<$Res> {
  factory _$LwkErrorCopyWith(_LwkError value, $Res Function(_LwkError) _then) =
      __$LwkErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$LwkErrorCopyWithImpl<$Res> implements _$LwkErrorCopyWith<$Res> {
  __$LwkErrorCopyWithImpl(this._self, this._then);

  final _LwkError _self;
  final $Res Function(_LwkError) _then;

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? msg = null,
  }) {
    return _then(_LwkError(
      msg: null == msg
          ? _self.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
