// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LwkError {
  String get msg => throw _privateConstructorUsedError;

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LwkErrorCopyWith<LwkError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LwkErrorCopyWith<$Res> {
  factory $LwkErrorCopyWith(LwkError value, $Res Function(LwkError) then) =
      _$LwkErrorCopyWithImpl<$Res, LwkError>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class _$LwkErrorCopyWithImpl<$Res, $Val extends LwkError>
    implements $LwkErrorCopyWith<$Res> {
  _$LwkErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_value.copyWith(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LwkErrorImplCopyWith<$Res>
    implements $LwkErrorCopyWith<$Res> {
  factory _$$LwkErrorImplCopyWith(
          _$LwkErrorImpl value, $Res Function(_$LwkErrorImpl) then) =
      __$$LwkErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$LwkErrorImplCopyWithImpl<$Res>
    extends _$LwkErrorCopyWithImpl<$Res, _$LwkErrorImpl>
    implements _$$LwkErrorImplCopyWith<$Res> {
  __$$LwkErrorImplCopyWithImpl(
      _$LwkErrorImpl _value, $Res Function(_$LwkErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$LwkErrorImpl(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LwkErrorImpl implements _LwkError {
  const _$LwkErrorImpl({required this.msg});

  @override
  final String msg;

  @override
  String toString() {
    return 'LwkError(msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LwkErrorImpl &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LwkErrorImplCopyWith<_$LwkErrorImpl> get copyWith =>
      __$$LwkErrorImplCopyWithImpl<_$LwkErrorImpl>(this, _$identity);
}

abstract class _LwkError implements LwkError {
  const factory _LwkError({required final String msg}) = _$LwkErrorImpl;

  @override
  String get msg;

  /// Create a copy of LwkError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LwkErrorImplCopyWith<_$LwkErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
