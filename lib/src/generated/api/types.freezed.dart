// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Address {
  String get standard => throw _privateConstructorUsedError;
  String get confidential => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call({String standard, String confidential, int index});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? standard = null,
    Object? confidential = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      standard: null == standard
          ? _value.standard
          : standard // ignore: cast_nullable_to_non_nullable
              as String,
      confidential: null == confidential
          ? _value.confidential
          : confidential // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String standard, String confidential, int index});
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? standard = null,
    Object? confidential = null,
    Object? index = null,
  }) {
    return _then(_$AddressImpl(
      standard: null == standard
          ? _value.standard
          : standard // ignore: cast_nullable_to_non_nullable
              as String,
      confidential: null == confidential
          ? _value.confidential
          : confidential // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AddressImpl extends _Address {
  const _$AddressImpl(
      {required this.standard, required this.confidential, required this.index})
      : super._();

  @override
  final String standard;
  @override
  final String confidential;
  @override
  final int index;

  @override
  String toString() {
    return 'Address(standard: $standard, confidential: $confidential, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.standard, standard) ||
                other.standard == standard) &&
            (identical(other.confidential, confidential) ||
                other.confidential == confidential) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, standard, confidential, index);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);
}

abstract class _Address extends Address {
  const factory _Address(
      {required final String standard,
      required final String confidential,
      required final int index}) = _$AddressImpl;
  const _Address._() : super._();

  @override
  String get standard;
  @override
  String get confidential;
  @override
  int get index;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Balance {
  String get assetId => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BalanceCopyWith<Balance> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceCopyWith<$Res> {
  factory $BalanceCopyWith(Balance value, $Res Function(Balance) then) =
      _$BalanceCopyWithImpl<$Res, Balance>;
  @useResult
  $Res call({String assetId, int value});
}

/// @nodoc
class _$BalanceCopyWithImpl<$Res, $Val extends Balance>
    implements $BalanceCopyWith<$Res> {
  _$BalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assetId = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      assetId: null == assetId
          ? _value.assetId
          : assetId // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceImplCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$$BalanceImplCopyWith(
          _$BalanceImpl value, $Res Function(_$BalanceImpl) then) =
      __$$BalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String assetId, int value});
}

/// @nodoc
class __$$BalanceImplCopyWithImpl<$Res>
    extends _$BalanceCopyWithImpl<$Res, _$BalanceImpl>
    implements _$$BalanceImplCopyWith<$Res> {
  __$$BalanceImplCopyWithImpl(
      _$BalanceImpl _value, $Res Function(_$BalanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assetId = null,
    Object? value = null,
  }) {
    return _then(_$BalanceImpl(
      assetId: null == assetId
          ? _value.assetId
          : assetId // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BalanceImpl implements _Balance {
  const _$BalanceImpl({required this.assetId, required this.value});

  @override
  final String assetId;
  @override
  final int value;

  @override
  String toString() {
    return 'Balance(assetId: $assetId, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceImpl &&
            (identical(other.assetId, assetId) || other.assetId == assetId) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assetId, value);

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      __$$BalanceImplCopyWithImpl<_$BalanceImpl>(this, _$identity);
}

abstract class _Balance implements Balance {
  const factory _Balance(
      {required final String assetId,
      required final int value}) = _$BalanceImpl;

  @override
  String get assetId;
  @override
  int get value;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OutPoint {
  String get txid => throw _privateConstructorUsedError;
  int get vout => throw _privateConstructorUsedError;

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutPointCopyWith<OutPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutPointCopyWith<$Res> {
  factory $OutPointCopyWith(OutPoint value, $Res Function(OutPoint) then) =
      _$OutPointCopyWithImpl<$Res, OutPoint>;
  @useResult
  $Res call({String txid, int vout});
}

/// @nodoc
class _$OutPointCopyWithImpl<$Res, $Val extends OutPoint>
    implements $OutPointCopyWith<$Res> {
  _$OutPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? vout = null,
  }) {
    return _then(_value.copyWith(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      vout: null == vout
          ? _value.vout
          : vout // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutPointImplCopyWith<$Res>
    implements $OutPointCopyWith<$Res> {
  factory _$$OutPointImplCopyWith(
          _$OutPointImpl value, $Res Function(_$OutPointImpl) then) =
      __$$OutPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txid, int vout});
}

/// @nodoc
class __$$OutPointImplCopyWithImpl<$Res>
    extends _$OutPointCopyWithImpl<$Res, _$OutPointImpl>
    implements _$$OutPointImplCopyWith<$Res> {
  __$$OutPointImplCopyWithImpl(
      _$OutPointImpl _value, $Res Function(_$OutPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? vout = null,
  }) {
    return _then(_$OutPointImpl(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      vout: null == vout
          ? _value.vout
          : vout // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$OutPointImpl implements _OutPoint {
  const _$OutPointImpl({required this.txid, required this.vout});

  @override
  final String txid;
  @override
  final int vout;

  @override
  String toString() {
    return 'OutPoint(txid: $txid, vout: $vout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutPointImpl &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.vout, vout) || other.vout == vout));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txid, vout);

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutPointImplCopyWith<_$OutPointImpl> get copyWith =>
      __$$OutPointImplCopyWithImpl<_$OutPointImpl>(this, _$identity);
}

abstract class _OutPoint implements OutPoint {
  const factory _OutPoint(
      {required final String txid, required final int vout}) = _$OutPointImpl;

  @override
  String get txid;
  @override
  int get vout;

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutPointImplCopyWith<_$OutPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Tx {
  int? get timestamp => throw _privateConstructorUsedError;
  String get kind => throw _privateConstructorUsedError;
  List<Balance> get balances => throw _privateConstructorUsedError;
  String get txid => throw _privateConstructorUsedError;
  List<TxOut> get outputs => throw _privateConstructorUsedError;
  List<TxOut> get inputs => throw _privateConstructorUsedError;
  BigInt get fee => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  String get unblindedUrl => throw _privateConstructorUsedError;
  BigInt get vsize => throw _privateConstructorUsedError;

  /// Create a copy of Tx
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TxCopyWith<Tx> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxCopyWith<$Res> {
  factory $TxCopyWith(Tx value, $Res Function(Tx) then) =
      _$TxCopyWithImpl<$Res, Tx>;
  @useResult
  $Res call(
      {int? timestamp,
      String kind,
      List<Balance> balances,
      String txid,
      List<TxOut> outputs,
      List<TxOut> inputs,
      BigInt fee,
      int? height,
      String unblindedUrl,
      BigInt vsize});
}

/// @nodoc
class _$TxCopyWithImpl<$Res, $Val extends Tx> implements $TxCopyWith<$Res> {
  _$TxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tx
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? kind = null,
    Object? balances = null,
    Object? txid = null,
    Object? outputs = null,
    Object? inputs = null,
    Object? fee = null,
    Object? height = freezed,
    Object? unblindedUrl = null,
    Object? vsize = null,
  }) {
    return _then(_value.copyWith(
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      balances: null == balances
          ? _value.balances
          : balances // ignore: cast_nullable_to_non_nullable
              as List<Balance>,
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      outputs: null == outputs
          ? _value.outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<TxOut>,
      inputs: null == inputs
          ? _value.inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as List<TxOut>,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      unblindedUrl: null == unblindedUrl
          ? _value.unblindedUrl
          : unblindedUrl // ignore: cast_nullable_to_non_nullable
              as String,
      vsize: null == vsize
          ? _value.vsize
          : vsize // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TxImplCopyWith<$Res> implements $TxCopyWith<$Res> {
  factory _$$TxImplCopyWith(_$TxImpl value, $Res Function(_$TxImpl) then) =
      __$$TxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? timestamp,
      String kind,
      List<Balance> balances,
      String txid,
      List<TxOut> outputs,
      List<TxOut> inputs,
      BigInt fee,
      int? height,
      String unblindedUrl,
      BigInt vsize});
}

/// @nodoc
class __$$TxImplCopyWithImpl<$Res> extends _$TxCopyWithImpl<$Res, _$TxImpl>
    implements _$$TxImplCopyWith<$Res> {
  __$$TxImplCopyWithImpl(_$TxImpl _value, $Res Function(_$TxImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tx
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? kind = null,
    Object? balances = null,
    Object? txid = null,
    Object? outputs = null,
    Object? inputs = null,
    Object? fee = null,
    Object? height = freezed,
    Object? unblindedUrl = null,
    Object? vsize = null,
  }) {
    return _then(_$TxImpl(
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      balances: null == balances
          ? _value._balances
          : balances // ignore: cast_nullable_to_non_nullable
              as List<Balance>,
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      outputs: null == outputs
          ? _value._outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<TxOut>,
      inputs: null == inputs
          ? _value._inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as List<TxOut>,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      unblindedUrl: null == unblindedUrl
          ? _value.unblindedUrl
          : unblindedUrl // ignore: cast_nullable_to_non_nullable
              as String,
      vsize: null == vsize
          ? _value.vsize
          : vsize // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc

class _$TxImpl implements _Tx {
  const _$TxImpl(
      {this.timestamp,
      required this.kind,
      required final List<Balance> balances,
      required this.txid,
      required final List<TxOut> outputs,
      required final List<TxOut> inputs,
      required this.fee,
      this.height,
      required this.unblindedUrl,
      required this.vsize})
      : _balances = balances,
        _outputs = outputs,
        _inputs = inputs;

  @override
  final int? timestamp;
  @override
  final String kind;
  final List<Balance> _balances;
  @override
  List<Balance> get balances {
    if (_balances is EqualUnmodifiableListView) return _balances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_balances);
  }

  @override
  final String txid;
  final List<TxOut> _outputs;
  @override
  List<TxOut> get outputs {
    if (_outputs is EqualUnmodifiableListView) return _outputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outputs);
  }

  final List<TxOut> _inputs;
  @override
  List<TxOut> get inputs {
    if (_inputs is EqualUnmodifiableListView) return _inputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inputs);
  }

  @override
  final BigInt fee;
  @override
  final int? height;
  @override
  final String unblindedUrl;
  @override
  final BigInt vsize;

  @override
  String toString() {
    return 'Tx(timestamp: $timestamp, kind: $kind, balances: $balances, txid: $txid, outputs: $outputs, inputs: $inputs, fee: $fee, height: $height, unblindedUrl: $unblindedUrl, vsize: $vsize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TxImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            const DeepCollectionEquality().equals(other._balances, _balances) &&
            (identical(other.txid, txid) || other.txid == txid) &&
            const DeepCollectionEquality().equals(other._outputs, _outputs) &&
            const DeepCollectionEquality().equals(other._inputs, _inputs) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.unblindedUrl, unblindedUrl) ||
                other.unblindedUrl == unblindedUrl) &&
            (identical(other.vsize, vsize) || other.vsize == vsize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      timestamp,
      kind,
      const DeepCollectionEquality().hash(_balances),
      txid,
      const DeepCollectionEquality().hash(_outputs),
      const DeepCollectionEquality().hash(_inputs),
      fee,
      height,
      unblindedUrl,
      vsize);

  /// Create a copy of Tx
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TxImplCopyWith<_$TxImpl> get copyWith =>
      __$$TxImplCopyWithImpl<_$TxImpl>(this, _$identity);
}

abstract class _Tx implements Tx {
  const factory _Tx(
      {final int? timestamp,
      required final String kind,
      required final List<Balance> balances,
      required final String txid,
      required final List<TxOut> outputs,
      required final List<TxOut> inputs,
      required final BigInt fee,
      final int? height,
      required final String unblindedUrl,
      required final BigInt vsize}) = _$TxImpl;

  @override
  int? get timestamp;
  @override
  String get kind;
  @override
  List<Balance> get balances;
  @override
  String get txid;
  @override
  List<TxOut> get outputs;
  @override
  List<TxOut> get inputs;
  @override
  BigInt get fee;
  @override
  int? get height;
  @override
  String get unblindedUrl;
  @override
  BigInt get vsize;

  /// Create a copy of Tx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TxImplCopyWith<_$TxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TxOut {
  String get scriptPubkey => throw _privateConstructorUsedError;
  OutPoint get outpoint => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  TxOutSecrets get unblinded => throw _privateConstructorUsedError;

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TxOutCopyWith<TxOut> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxOutCopyWith<$Res> {
  factory $TxOutCopyWith(TxOut value, $Res Function(TxOut) then) =
      _$TxOutCopyWithImpl<$Res, TxOut>;
  @useResult
  $Res call(
      {String scriptPubkey,
      OutPoint outpoint,
      int? height,
      TxOutSecrets unblinded});

  $OutPointCopyWith<$Res> get outpoint;
  $TxOutSecretsCopyWith<$Res> get unblinded;
}

/// @nodoc
class _$TxOutCopyWithImpl<$Res, $Val extends TxOut>
    implements $TxOutCopyWith<$Res> {
  _$TxOutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scriptPubkey = null,
    Object? outpoint = null,
    Object? height = freezed,
    Object? unblinded = null,
  }) {
    return _then(_value.copyWith(
      scriptPubkey: null == scriptPubkey
          ? _value.scriptPubkey
          : scriptPubkey // ignore: cast_nullable_to_non_nullable
              as String,
      outpoint: null == outpoint
          ? _value.outpoint
          : outpoint // ignore: cast_nullable_to_non_nullable
              as OutPoint,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      unblinded: null == unblinded
          ? _value.unblinded
          : unblinded // ignore: cast_nullable_to_non_nullable
              as TxOutSecrets,
    ) as $Val);
  }

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutPointCopyWith<$Res> get outpoint {
    return $OutPointCopyWith<$Res>(_value.outpoint, (value) {
      return _then(_value.copyWith(outpoint: value) as $Val);
    });
  }

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TxOutSecretsCopyWith<$Res> get unblinded {
    return $TxOutSecretsCopyWith<$Res>(_value.unblinded, (value) {
      return _then(_value.copyWith(unblinded: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TxOutImplCopyWith<$Res> implements $TxOutCopyWith<$Res> {
  factory _$$TxOutImplCopyWith(
          _$TxOutImpl value, $Res Function(_$TxOutImpl) then) =
      __$$TxOutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String scriptPubkey,
      OutPoint outpoint,
      int? height,
      TxOutSecrets unblinded});

  @override
  $OutPointCopyWith<$Res> get outpoint;
  @override
  $TxOutSecretsCopyWith<$Res> get unblinded;
}

/// @nodoc
class __$$TxOutImplCopyWithImpl<$Res>
    extends _$TxOutCopyWithImpl<$Res, _$TxOutImpl>
    implements _$$TxOutImplCopyWith<$Res> {
  __$$TxOutImplCopyWithImpl(
      _$TxOutImpl _value, $Res Function(_$TxOutImpl) _then)
      : super(_value, _then);

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scriptPubkey = null,
    Object? outpoint = null,
    Object? height = freezed,
    Object? unblinded = null,
  }) {
    return _then(_$TxOutImpl(
      scriptPubkey: null == scriptPubkey
          ? _value.scriptPubkey
          : scriptPubkey // ignore: cast_nullable_to_non_nullable
              as String,
      outpoint: null == outpoint
          ? _value.outpoint
          : outpoint // ignore: cast_nullable_to_non_nullable
              as OutPoint,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      unblinded: null == unblinded
          ? _value.unblinded
          : unblinded // ignore: cast_nullable_to_non_nullable
              as TxOutSecrets,
    ));
  }
}

/// @nodoc

class _$TxOutImpl implements _TxOut {
  const _$TxOutImpl(
      {required this.scriptPubkey,
      required this.outpoint,
      this.height,
      required this.unblinded});

  @override
  final String scriptPubkey;
  @override
  final OutPoint outpoint;
  @override
  final int? height;
  @override
  final TxOutSecrets unblinded;

  @override
  String toString() {
    return 'TxOut(scriptPubkey: $scriptPubkey, outpoint: $outpoint, height: $height, unblinded: $unblinded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TxOutImpl &&
            (identical(other.scriptPubkey, scriptPubkey) ||
                other.scriptPubkey == scriptPubkey) &&
            (identical(other.outpoint, outpoint) ||
                other.outpoint == outpoint) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.unblinded, unblinded) ||
                other.unblinded == unblinded));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, scriptPubkey, outpoint, height, unblinded);

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TxOutImplCopyWith<_$TxOutImpl> get copyWith =>
      __$$TxOutImplCopyWithImpl<_$TxOutImpl>(this, _$identity);
}

abstract class _TxOut implements TxOut {
  const factory _TxOut(
      {required final String scriptPubkey,
      required final OutPoint outpoint,
      final int? height,
      required final TxOutSecrets unblinded}) = _$TxOutImpl;

  @override
  String get scriptPubkey;
  @override
  OutPoint get outpoint;
  @override
  int? get height;
  @override
  TxOutSecrets get unblinded;

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TxOutImplCopyWith<_$TxOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TxOutSecrets {
  BigInt get value => throw _privateConstructorUsedError;
  String get valueBf => throw _privateConstructorUsedError;
  String get asset => throw _privateConstructorUsedError;
  String get assetBf => throw _privateConstructorUsedError;

  /// Create a copy of TxOutSecrets
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TxOutSecretsCopyWith<TxOutSecrets> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxOutSecretsCopyWith<$Res> {
  factory $TxOutSecretsCopyWith(
          TxOutSecrets value, $Res Function(TxOutSecrets) then) =
      _$TxOutSecretsCopyWithImpl<$Res, TxOutSecrets>;
  @useResult
  $Res call({BigInt value, String valueBf, String asset, String assetBf});
}

/// @nodoc
class _$TxOutSecretsCopyWithImpl<$Res, $Val extends TxOutSecrets>
    implements $TxOutSecretsCopyWith<$Res> {
  _$TxOutSecretsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TxOutSecrets
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? valueBf = null,
    Object? asset = null,
    Object? assetBf = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      valueBf: null == valueBf
          ? _value.valueBf
          : valueBf // ignore: cast_nullable_to_non_nullable
              as String,
      asset: null == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String,
      assetBf: null == assetBf
          ? _value.assetBf
          : assetBf // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TxOutSecretsImplCopyWith<$Res>
    implements $TxOutSecretsCopyWith<$Res> {
  factory _$$TxOutSecretsImplCopyWith(
          _$TxOutSecretsImpl value, $Res Function(_$TxOutSecretsImpl) then) =
      __$$TxOutSecretsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BigInt value, String valueBf, String asset, String assetBf});
}

/// @nodoc
class __$$TxOutSecretsImplCopyWithImpl<$Res>
    extends _$TxOutSecretsCopyWithImpl<$Res, _$TxOutSecretsImpl>
    implements _$$TxOutSecretsImplCopyWith<$Res> {
  __$$TxOutSecretsImplCopyWithImpl(
      _$TxOutSecretsImpl _value, $Res Function(_$TxOutSecretsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TxOutSecrets
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? valueBf = null,
    Object? asset = null,
    Object? assetBf = null,
  }) {
    return _then(_$TxOutSecretsImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      valueBf: null == valueBf
          ? _value.valueBf
          : valueBf // ignore: cast_nullable_to_non_nullable
              as String,
      asset: null == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String,
      assetBf: null == assetBf
          ? _value.assetBf
          : assetBf // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TxOutSecretsImpl implements _TxOutSecrets {
  const _$TxOutSecretsImpl(
      {required this.value,
      required this.valueBf,
      required this.asset,
      required this.assetBf});

  @override
  final BigInt value;
  @override
  final String valueBf;
  @override
  final String asset;
  @override
  final String assetBf;

  @override
  String toString() {
    return 'TxOutSecrets(value: $value, valueBf: $valueBf, asset: $asset, assetBf: $assetBf)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TxOutSecretsImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.valueBf, valueBf) || other.valueBf == valueBf) &&
            (identical(other.asset, asset) || other.asset == asset) &&
            (identical(other.assetBf, assetBf) || other.assetBf == assetBf));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, valueBf, asset, assetBf);

  /// Create a copy of TxOutSecrets
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TxOutSecretsImplCopyWith<_$TxOutSecretsImpl> get copyWith =>
      __$$TxOutSecretsImplCopyWithImpl<_$TxOutSecretsImpl>(this, _$identity);
}

abstract class _TxOutSecrets implements TxOutSecrets {
  const factory _TxOutSecrets(
      {required final BigInt value,
      required final String valueBf,
      required final String asset,
      required final String assetBf}) = _$TxOutSecretsImpl;

  @override
  BigInt get value;
  @override
  String get valueBf;
  @override
  String get asset;
  @override
  String get assetBf;

  /// Create a copy of TxOutSecrets
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TxOutSecretsImplCopyWith<_$TxOutSecretsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
