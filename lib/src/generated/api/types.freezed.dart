// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Address {
  String get standard;
  String get confidential;
  int? get index;
  String? get blindingKey;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressCopyWith<Address> get copyWith =>
      _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Address &&
            (identical(other.standard, standard) ||
                other.standard == standard) &&
            (identical(other.confidential, confidential) ||
                other.confidential == confidential) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.blindingKey, blindingKey) ||
                other.blindingKey == blindingKey));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, standard, confidential, index, blindingKey);

  @override
  String toString() {
    return 'Address(standard: $standard, confidential: $confidential, index: $index, blindingKey: $blindingKey)';
  }
}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) =
      _$AddressCopyWithImpl;
  @useResult
  $Res call(
      {String standard, String confidential, int? index, String? blindingKey});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? standard = null,
    Object? confidential = null,
    Object? index = freezed,
    Object? blindingKey = freezed,
  }) {
    return _then(_self.copyWith(
      standard: null == standard
          ? _self.standard
          : standard // ignore: cast_nullable_to_non_nullable
              as String,
      confidential: null == confidential
          ? _self.confidential
          : confidential // ignore: cast_nullable_to_non_nullable
              as String,
      index: freezed == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      blindingKey: freezed == blindingKey
          ? _self.blindingKey
          : blindingKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _Address extends Address {
  const _Address(
      {required this.standard,
      required this.confidential,
      this.index,
      this.blindingKey})
      : super._();

  @override
  final String standard;
  @override
  final String confidential;
  @override
  final int? index;
  @override
  final String? blindingKey;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddressCopyWith<_Address> get copyWith =>
      __$AddressCopyWithImpl<_Address>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Address &&
            (identical(other.standard, standard) ||
                other.standard == standard) &&
            (identical(other.confidential, confidential) ||
                other.confidential == confidential) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.blindingKey, blindingKey) ||
                other.blindingKey == blindingKey));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, standard, confidential, index, blindingKey);

  @override
  String toString() {
    return 'Address(standard: $standard, confidential: $confidential, index: $index, blindingKey: $blindingKey)';
  }
}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) =
      __$AddressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String standard, String confidential, int? index, String? blindingKey});
}

/// @nodoc
class __$AddressCopyWithImpl<$Res> implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? standard = null,
    Object? confidential = null,
    Object? index = freezed,
    Object? blindingKey = freezed,
  }) {
    return _then(_Address(
      standard: null == standard
          ? _self.standard
          : standard // ignore: cast_nullable_to_non_nullable
              as String,
      confidential: null == confidential
          ? _self.confidential
          : confidential // ignore: cast_nullable_to_non_nullable
              as String,
      index: freezed == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      blindingKey: freezed == blindingKey
          ? _self.blindingKey
          : blindingKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Balance {
  String get assetId;
  PlatformInt64 get value;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BalanceCopyWith<Balance> get copyWith =>
      _$BalanceCopyWithImpl<Balance>(this as Balance, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Balance &&
            (identical(other.assetId, assetId) || other.assetId == assetId) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assetId, value);

  @override
  String toString() {
    return 'Balance(assetId: $assetId, value: $value)';
  }
}

/// @nodoc
abstract mixin class $BalanceCopyWith<$Res> {
  factory $BalanceCopyWith(Balance value, $Res Function(Balance) _then) =
      _$BalanceCopyWithImpl;
  @useResult
  $Res call({String assetId, PlatformInt64 value});
}

/// @nodoc
class _$BalanceCopyWithImpl<$Res> implements $BalanceCopyWith<$Res> {
  _$BalanceCopyWithImpl(this._self, this._then);

  final Balance _self;
  final $Res Function(Balance) _then;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assetId = null,
    Object? value = null,
  }) {
    return _then(_self.copyWith(
      assetId: null == assetId
          ? _self.assetId
          : assetId // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as PlatformInt64,
    ));
  }
}

/// @nodoc

class _Balance implements Balance {
  const _Balance({required this.assetId, required this.value});

  @override
  final String assetId;
  @override
  final PlatformInt64 value;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BalanceCopyWith<_Balance> get copyWith =>
      __$BalanceCopyWithImpl<_Balance>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Balance &&
            (identical(other.assetId, assetId) || other.assetId == assetId) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assetId, value);

  @override
  String toString() {
    return 'Balance(assetId: $assetId, value: $value)';
  }
}

/// @nodoc
abstract mixin class _$BalanceCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$BalanceCopyWith(_Balance value, $Res Function(_Balance) _then) =
      __$BalanceCopyWithImpl;
  @override
  @useResult
  $Res call({String assetId, PlatformInt64 value});
}

/// @nodoc
class __$BalanceCopyWithImpl<$Res> implements _$BalanceCopyWith<$Res> {
  __$BalanceCopyWithImpl(this._self, this._then);

  final _Balance _self;
  final $Res Function(_Balance) _then;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? assetId = null,
    Object? value = null,
  }) {
    return _then(_Balance(
      assetId: null == assetId
          ? _self.assetId
          : assetId // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as PlatformInt64,
    ));
  }
}

/// @nodoc
mixin _$OutPoint {
  String get txid;
  int get vout;

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OutPointCopyWith<OutPoint> get copyWith =>
      _$OutPointCopyWithImpl<OutPoint>(this as OutPoint, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OutPoint &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.vout, vout) || other.vout == vout));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txid, vout);

  @override
  String toString() {
    return 'OutPoint(txid: $txid, vout: $vout)';
  }
}

/// @nodoc
abstract mixin class $OutPointCopyWith<$Res> {
  factory $OutPointCopyWith(OutPoint value, $Res Function(OutPoint) _then) =
      _$OutPointCopyWithImpl;
  @useResult
  $Res call({String txid, int vout});
}

/// @nodoc
class _$OutPointCopyWithImpl<$Res> implements $OutPointCopyWith<$Res> {
  _$OutPointCopyWithImpl(this._self, this._then);

  final OutPoint _self;
  final $Res Function(OutPoint) _then;

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? vout = null,
  }) {
    return _then(_self.copyWith(
      txid: null == txid
          ? _self.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      vout: null == vout
          ? _self.vout
          : vout // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _OutPoint implements OutPoint {
  const _OutPoint({required this.txid, required this.vout});

  @override
  final String txid;
  @override
  final int vout;

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OutPointCopyWith<_OutPoint> get copyWith =>
      __$OutPointCopyWithImpl<_OutPoint>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OutPoint &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.vout, vout) || other.vout == vout));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txid, vout);

  @override
  String toString() {
    return 'OutPoint(txid: $txid, vout: $vout)';
  }
}

/// @nodoc
abstract mixin class _$OutPointCopyWith<$Res>
    implements $OutPointCopyWith<$Res> {
  factory _$OutPointCopyWith(_OutPoint value, $Res Function(_OutPoint) _then) =
      __$OutPointCopyWithImpl;
  @override
  @useResult
  $Res call({String txid, int vout});
}

/// @nodoc
class __$OutPointCopyWithImpl<$Res> implements _$OutPointCopyWith<$Res> {
  __$OutPointCopyWithImpl(this._self, this._then);

  final _OutPoint _self;
  final $Res Function(_OutPoint) _then;

  /// Create a copy of OutPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? txid = null,
    Object? vout = null,
  }) {
    return _then(_OutPoint(
      txid: null == txid
          ? _self.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      vout: null == vout
          ? _self.vout
          : vout // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Tx {
  int? get timestamp;
  String get kind;
  List<Balance> get balances;
  String get txid;
  List<TxOut> get outputs;
  List<TxOut> get inputs;
  BigInt get fee;
  int? get height;
  String get unblindedUrl;
  BigInt get vsize;

  /// Create a copy of Tx
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TxCopyWith<Tx> get copyWith => _$TxCopyWithImpl<Tx>(this as Tx, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Tx &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            const DeepCollectionEquality().equals(other.balances, balances) &&
            (identical(other.txid, txid) || other.txid == txid) &&
            const DeepCollectionEquality().equals(other.outputs, outputs) &&
            const DeepCollectionEquality().equals(other.inputs, inputs) &&
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
      const DeepCollectionEquality().hash(balances),
      txid,
      const DeepCollectionEquality().hash(outputs),
      const DeepCollectionEquality().hash(inputs),
      fee,
      height,
      unblindedUrl,
      vsize);

  @override
  String toString() {
    return 'Tx(timestamp: $timestamp, kind: $kind, balances: $balances, txid: $txid, outputs: $outputs, inputs: $inputs, fee: $fee, height: $height, unblindedUrl: $unblindedUrl, vsize: $vsize)';
  }
}

/// @nodoc
abstract mixin class $TxCopyWith<$Res> {
  factory $TxCopyWith(Tx value, $Res Function(Tx) _then) = _$TxCopyWithImpl;
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
class _$TxCopyWithImpl<$Res> implements $TxCopyWith<$Res> {
  _$TxCopyWithImpl(this._self, this._then);

  final Tx _self;
  final $Res Function(Tx) _then;

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
    return _then(_self.copyWith(
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      kind: null == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      balances: null == balances
          ? _self.balances
          : balances // ignore: cast_nullable_to_non_nullable
              as List<Balance>,
      txid: null == txid
          ? _self.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      outputs: null == outputs
          ? _self.outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<TxOut>,
      inputs: null == inputs
          ? _self.inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as List<TxOut>,
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      unblindedUrl: null == unblindedUrl
          ? _self.unblindedUrl
          : unblindedUrl // ignore: cast_nullable_to_non_nullable
              as String,
      vsize: null == vsize
          ? _self.vsize
          : vsize // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc

class _Tx implements Tx {
  const _Tx(
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

  /// Create a copy of Tx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TxCopyWith<_Tx> get copyWith => __$TxCopyWithImpl<_Tx>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Tx &&
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

  @override
  String toString() {
    return 'Tx(timestamp: $timestamp, kind: $kind, balances: $balances, txid: $txid, outputs: $outputs, inputs: $inputs, fee: $fee, height: $height, unblindedUrl: $unblindedUrl, vsize: $vsize)';
  }
}

/// @nodoc
abstract mixin class _$TxCopyWith<$Res> implements $TxCopyWith<$Res> {
  factory _$TxCopyWith(_Tx value, $Res Function(_Tx) _then) = __$TxCopyWithImpl;
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
class __$TxCopyWithImpl<$Res> implements _$TxCopyWith<$Res> {
  __$TxCopyWithImpl(this._self, this._then);

  final _Tx _self;
  final $Res Function(_Tx) _then;

  /// Create a copy of Tx
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Tx(
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      kind: null == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      balances: null == balances
          ? _self._balances
          : balances // ignore: cast_nullable_to_non_nullable
              as List<Balance>,
      txid: null == txid
          ? _self.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      outputs: null == outputs
          ? _self._outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<TxOut>,
      inputs: null == inputs
          ? _self._inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as List<TxOut>,
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      unblindedUrl: null == unblindedUrl
          ? _self.unblindedUrl
          : unblindedUrl // ignore: cast_nullable_to_non_nullable
              as String,
      vsize: null == vsize
          ? _self.vsize
          : vsize // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
mixin _$TxOut {
  String get scriptPubkey;
  OutPoint get outpoint;
  int? get height;
  TxOutSecrets get unblinded;
  bool get isSpent;
  Address get address;

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TxOutCopyWith<TxOut> get copyWith =>
      _$TxOutCopyWithImpl<TxOut>(this as TxOut, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TxOut &&
            (identical(other.scriptPubkey, scriptPubkey) ||
                other.scriptPubkey == scriptPubkey) &&
            (identical(other.outpoint, outpoint) ||
                other.outpoint == outpoint) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.unblinded, unblinded) ||
                other.unblinded == unblinded) &&
            (identical(other.isSpent, isSpent) || other.isSpent == isSpent) &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, scriptPubkey, outpoint, height, unblinded, isSpent, address);

  @override
  String toString() {
    return 'TxOut(scriptPubkey: $scriptPubkey, outpoint: $outpoint, height: $height, unblinded: $unblinded, isSpent: $isSpent, address: $address)';
  }
}

/// @nodoc
abstract mixin class $TxOutCopyWith<$Res> {
  factory $TxOutCopyWith(TxOut value, $Res Function(TxOut) _then) =
      _$TxOutCopyWithImpl;
  @useResult
  $Res call(
      {String scriptPubkey,
      OutPoint outpoint,
      int? height,
      TxOutSecrets unblinded,
      bool isSpent,
      Address address});

  $OutPointCopyWith<$Res> get outpoint;
  $TxOutSecretsCopyWith<$Res> get unblinded;
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$TxOutCopyWithImpl<$Res> implements $TxOutCopyWith<$Res> {
  _$TxOutCopyWithImpl(this._self, this._then);

  final TxOut _self;
  final $Res Function(TxOut) _then;

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scriptPubkey = null,
    Object? outpoint = null,
    Object? height = freezed,
    Object? unblinded = null,
    Object? isSpent = null,
    Object? address = null,
  }) {
    return _then(_self.copyWith(
      scriptPubkey: null == scriptPubkey
          ? _self.scriptPubkey
          : scriptPubkey // ignore: cast_nullable_to_non_nullable
              as String,
      outpoint: null == outpoint
          ? _self.outpoint
          : outpoint // ignore: cast_nullable_to_non_nullable
              as OutPoint,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      unblinded: null == unblinded
          ? _self.unblinded
          : unblinded // ignore: cast_nullable_to_non_nullable
              as TxOutSecrets,
      isSpent: null == isSpent
          ? _self.isSpent
          : isSpent // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutPointCopyWith<$Res> get outpoint {
    return $OutPointCopyWith<$Res>(_self.outpoint, (value) {
      return _then(_self.copyWith(outpoint: value));
    });
  }

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TxOutSecretsCopyWith<$Res> get unblinded {
    return $TxOutSecretsCopyWith<$Res>(_self.unblinded, (value) {
      return _then(_self.copyWith(unblinded: value));
    });
  }

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

/// @nodoc

class _TxOut implements TxOut {
  const _TxOut(
      {required this.scriptPubkey,
      required this.outpoint,
      this.height,
      required this.unblinded,
      required this.isSpent,
      required this.address});

  @override
  final String scriptPubkey;
  @override
  final OutPoint outpoint;
  @override
  final int? height;
  @override
  final TxOutSecrets unblinded;
  @override
  final bool isSpent;
  @override
  final Address address;

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TxOutCopyWith<_TxOut> get copyWith =>
      __$TxOutCopyWithImpl<_TxOut>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TxOut &&
            (identical(other.scriptPubkey, scriptPubkey) ||
                other.scriptPubkey == scriptPubkey) &&
            (identical(other.outpoint, outpoint) ||
                other.outpoint == outpoint) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.unblinded, unblinded) ||
                other.unblinded == unblinded) &&
            (identical(other.isSpent, isSpent) || other.isSpent == isSpent) &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, scriptPubkey, outpoint, height, unblinded, isSpent, address);

  @override
  String toString() {
    return 'TxOut(scriptPubkey: $scriptPubkey, outpoint: $outpoint, height: $height, unblinded: $unblinded, isSpent: $isSpent, address: $address)';
  }
}

/// @nodoc
abstract mixin class _$TxOutCopyWith<$Res> implements $TxOutCopyWith<$Res> {
  factory _$TxOutCopyWith(_TxOut value, $Res Function(_TxOut) _then) =
      __$TxOutCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String scriptPubkey,
      OutPoint outpoint,
      int? height,
      TxOutSecrets unblinded,
      bool isSpent,
      Address address});

  @override
  $OutPointCopyWith<$Res> get outpoint;
  @override
  $TxOutSecretsCopyWith<$Res> get unblinded;
  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$TxOutCopyWithImpl<$Res> implements _$TxOutCopyWith<$Res> {
  __$TxOutCopyWithImpl(this._self, this._then);

  final _TxOut _self;
  final $Res Function(_TxOut) _then;

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? scriptPubkey = null,
    Object? outpoint = null,
    Object? height = freezed,
    Object? unblinded = null,
    Object? isSpent = null,
    Object? address = null,
  }) {
    return _then(_TxOut(
      scriptPubkey: null == scriptPubkey
          ? _self.scriptPubkey
          : scriptPubkey // ignore: cast_nullable_to_non_nullable
              as String,
      outpoint: null == outpoint
          ? _self.outpoint
          : outpoint // ignore: cast_nullable_to_non_nullable
              as OutPoint,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      unblinded: null == unblinded
          ? _self.unblinded
          : unblinded // ignore: cast_nullable_to_non_nullable
              as TxOutSecrets,
      isSpent: null == isSpent
          ? _self.isSpent
          : isSpent // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutPointCopyWith<$Res> get outpoint {
    return $OutPointCopyWith<$Res>(_self.outpoint, (value) {
      return _then(_self.copyWith(outpoint: value));
    });
  }

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TxOutSecretsCopyWith<$Res> get unblinded {
    return $TxOutSecretsCopyWith<$Res>(_self.unblinded, (value) {
      return _then(_self.copyWith(unblinded: value));
    });
  }

  /// Create a copy of TxOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

/// @nodoc
mixin _$TxOutSecrets {
  BigInt get value;
  String get valueBf;
  String get asset;
  String get assetBf;

  /// Create a copy of TxOutSecrets
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TxOutSecretsCopyWith<TxOutSecrets> get copyWith =>
      _$TxOutSecretsCopyWithImpl<TxOutSecrets>(
          this as TxOutSecrets, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TxOutSecrets &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.valueBf, valueBf) || other.valueBf == valueBf) &&
            (identical(other.asset, asset) || other.asset == asset) &&
            (identical(other.assetBf, assetBf) || other.assetBf == assetBf));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, valueBf, asset, assetBf);

  @override
  String toString() {
    return 'TxOutSecrets(value: $value, valueBf: $valueBf, asset: $asset, assetBf: $assetBf)';
  }
}

/// @nodoc
abstract mixin class $TxOutSecretsCopyWith<$Res> {
  factory $TxOutSecretsCopyWith(
          TxOutSecrets value, $Res Function(TxOutSecrets) _then) =
      _$TxOutSecretsCopyWithImpl;
  @useResult
  $Res call({BigInt value, String valueBf, String asset, String assetBf});
}

/// @nodoc
class _$TxOutSecretsCopyWithImpl<$Res> implements $TxOutSecretsCopyWith<$Res> {
  _$TxOutSecretsCopyWithImpl(this._self, this._then);

  final TxOutSecrets _self;
  final $Res Function(TxOutSecrets) _then;

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
    return _then(_self.copyWith(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      valueBf: null == valueBf
          ? _self.valueBf
          : valueBf // ignore: cast_nullable_to_non_nullable
              as String,
      asset: null == asset
          ? _self.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String,
      assetBf: null == assetBf
          ? _self.assetBf
          : assetBf // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _TxOutSecrets implements TxOutSecrets {
  const _TxOutSecrets(
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

  /// Create a copy of TxOutSecrets
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TxOutSecretsCopyWith<_TxOutSecrets> get copyWith =>
      __$TxOutSecretsCopyWithImpl<_TxOutSecrets>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TxOutSecrets &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.valueBf, valueBf) || other.valueBf == valueBf) &&
            (identical(other.asset, asset) || other.asset == asset) &&
            (identical(other.assetBf, assetBf) || other.assetBf == assetBf));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, valueBf, asset, assetBf);

  @override
  String toString() {
    return 'TxOutSecrets(value: $value, valueBf: $valueBf, asset: $asset, assetBf: $assetBf)';
  }
}

/// @nodoc
abstract mixin class _$TxOutSecretsCopyWith<$Res>
    implements $TxOutSecretsCopyWith<$Res> {
  factory _$TxOutSecretsCopyWith(
          _TxOutSecrets value, $Res Function(_TxOutSecrets) _then) =
      __$TxOutSecretsCopyWithImpl;
  @override
  @useResult
  $Res call({BigInt value, String valueBf, String asset, String assetBf});
}

/// @nodoc
class __$TxOutSecretsCopyWithImpl<$Res>
    implements _$TxOutSecretsCopyWith<$Res> {
  __$TxOutSecretsCopyWithImpl(this._self, this._then);

  final _TxOutSecrets _self;
  final $Res Function(_TxOutSecrets) _then;

  /// Create a copy of TxOutSecrets
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
    Object? valueBf = null,
    Object? asset = null,
    Object? assetBf = null,
  }) {
    return _then(_TxOutSecrets(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      valueBf: null == valueBf
          ? _self.valueBf
          : valueBf // ignore: cast_nullable_to_non_nullable
              as String,
      asset: null == asset
          ? _self.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String,
      assetBf: null == assetBf
          ? _self.assetBf
          : assetBf // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
