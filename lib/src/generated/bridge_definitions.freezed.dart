// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_definitions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LwkError {
  String get msg => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String msg) generic,
    required TResult Function(String msg) poisonError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String msg)? generic,
    TResult? Function(String msg)? poisonError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String msg)? generic,
    TResult Function(String msg)? poisonError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LwkError_Generic value) generic,
    required TResult Function(LwkError_PoisonError value) poisonError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LwkError_Generic value)? generic,
    TResult? Function(LwkError_PoisonError value)? poisonError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LwkError_Generic value)? generic,
    TResult Function(LwkError_PoisonError value)? poisonError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
abstract class _$$LwkError_GenericImplCopyWith<$Res>
    implements $LwkErrorCopyWith<$Res> {
  factory _$$LwkError_GenericImplCopyWith(_$LwkError_GenericImpl value,
          $Res Function(_$LwkError_GenericImpl) then) =
      __$$LwkError_GenericImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$LwkError_GenericImplCopyWithImpl<$Res>
    extends _$LwkErrorCopyWithImpl<$Res, _$LwkError_GenericImpl>
    implements _$$LwkError_GenericImplCopyWith<$Res> {
  __$$LwkError_GenericImplCopyWithImpl(_$LwkError_GenericImpl _value,
      $Res Function(_$LwkError_GenericImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$LwkError_GenericImpl(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LwkError_GenericImpl implements LwkError_Generic {
  const _$LwkError_GenericImpl({required this.msg});

  @override
  final String msg;

  @override
  String toString() {
    return 'LwkError.generic(msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LwkError_GenericImpl &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LwkError_GenericImplCopyWith<_$LwkError_GenericImpl> get copyWith =>
      __$$LwkError_GenericImplCopyWithImpl<_$LwkError_GenericImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String msg) generic,
    required TResult Function(String msg) poisonError,
  }) {
    return generic(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String msg)? generic,
    TResult? Function(String msg)? poisonError,
  }) {
    return generic?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String msg)? generic,
    TResult Function(String msg)? poisonError,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LwkError_Generic value) generic,
    required TResult Function(LwkError_PoisonError value) poisonError,
  }) {
    return generic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LwkError_Generic value)? generic,
    TResult? Function(LwkError_PoisonError value)? poisonError,
  }) {
    return generic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LwkError_Generic value)? generic,
    TResult Function(LwkError_PoisonError value)? poisonError,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(this);
    }
    return orElse();
  }
}

abstract class LwkError_Generic implements LwkError {
  const factory LwkError_Generic({required final String msg}) =
      _$LwkError_GenericImpl;

  @override
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$LwkError_GenericImplCopyWith<_$LwkError_GenericImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LwkError_PoisonErrorImplCopyWith<$Res>
    implements $LwkErrorCopyWith<$Res> {
  factory _$$LwkError_PoisonErrorImplCopyWith(_$LwkError_PoisonErrorImpl value,
          $Res Function(_$LwkError_PoisonErrorImpl) then) =
      __$$LwkError_PoisonErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$LwkError_PoisonErrorImplCopyWithImpl<$Res>
    extends _$LwkErrorCopyWithImpl<$Res, _$LwkError_PoisonErrorImpl>
    implements _$$LwkError_PoisonErrorImplCopyWith<$Res> {
  __$$LwkError_PoisonErrorImplCopyWithImpl(_$LwkError_PoisonErrorImpl _value,
      $Res Function(_$LwkError_PoisonErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$LwkError_PoisonErrorImpl(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LwkError_PoisonErrorImpl implements LwkError_PoisonError {
  const _$LwkError_PoisonErrorImpl({required this.msg});

  @override
  final String msg;

  @override
  String toString() {
    return 'LwkError.poisonError(msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LwkError_PoisonErrorImpl &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LwkError_PoisonErrorImplCopyWith<_$LwkError_PoisonErrorImpl>
      get copyWith =>
          __$$LwkError_PoisonErrorImplCopyWithImpl<_$LwkError_PoisonErrorImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String msg) generic,
    required TResult Function(String msg) poisonError,
  }) {
    return poisonError(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String msg)? generic,
    TResult? Function(String msg)? poisonError,
  }) {
    return poisonError?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String msg)? generic,
    TResult Function(String msg)? poisonError,
    required TResult orElse(),
  }) {
    if (poisonError != null) {
      return poisonError(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LwkError_Generic value) generic,
    required TResult Function(LwkError_PoisonError value) poisonError,
  }) {
    return poisonError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LwkError_Generic value)? generic,
    TResult? Function(LwkError_PoisonError value)? poisonError,
  }) {
    return poisonError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LwkError_Generic value)? generic,
    TResult Function(LwkError_PoisonError value)? poisonError,
    required TResult orElse(),
  }) {
    if (poisonError != null) {
      return poisonError(this);
    }
    return orElse();
  }
}

abstract class LwkError_PoisonError implements LwkError {
  const factory LwkError_PoisonError({required final String msg}) =
      _$LwkError_PoisonErrorImpl;

  @override
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$LwkError_PoisonErrorImplCopyWith<_$LwkError_PoisonErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
