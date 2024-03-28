import 'dart:io';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:lwk_dart/src/utils/loader.dart';
import 'generated/bridge_definitions.dart';

const lBtcAssetId =
    "6f0279e9ed041c3d710a9f57d0c02928416460c4b722ae3457a11eec381c526d";

const lTestAssetId =
    "144c654344aa716d6f3abcc1ca90e5641e4e2a7f633bc09fe3baf64585819a49";

Future<void> setCurrentDirectory() async {
  try {
    await Dylib.downloadUnitTestDylib(Directory.current.path);
  } catch (e) {
    print(e.toString());
  }
}

typedef Balances = List<(String, int)>;

class Descriptor {
  final String _descriptor;
  Descriptor._(this._descriptor);
  String get descriptor => _descriptor;

  static Future<Descriptor> create({
    required Network network,
    required String mnemonic,
    dynamic hint,
  }) async {
    try {
      final res = await ffi.newDescriptorStaticMethodApi(
        network: network,
        mnemonic: mnemonic,
      );
      return Descriptor._(res);
    } catch (e) {
      rethrow;
    }
  }
}

class Wallet {
  final String _liquidWallet;

  Wallet._(this._liquidWallet);

  String get liquidWallet => _liquidWallet;

  static Future<Wallet> create({
    required Network network,
    required String dbPath,
    required String descriptor,
    dynamic hint,
  }) async {
    try {
      final res = await ffi.newWalletStaticMethodApi(
        network: network,
        dbPath: dbPath,
        descriptor: descriptor,
      );
      return Wallet._(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sync(
    String electrumUrl,
  ) async {
    try {
      final res = await ffi.syncStaticMethodApi(
        walletId: _liquidWallet,
        electrumUrl: electrumUrl,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Address> addressAtIndex(int index) async {
    try {
      final res = await ffi.addressStaticMethodApi(
          walletId: _liquidWallet, index: index);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Address> lastUnusedAddress() async {
    try {
      final res = await ffi.addressLastUnusedStaticMethodApi(
        walletId: _liquidWallet,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> descriptor() async {
    try {
      final res = await ffi.walletDescriptorStaticMethodApi(
        walletId: _liquidWallet,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Balances> balance() async {
    try {
      final res = await ffi.balanceStaticMethodApi(walletId: _liquidWallet);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Tx>> txs() async {
    try {
      final res = await ffi.txsStaticMethodApi(walletId: _liquidWallet);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> build(
      {required int sats,
      required String outAddress,
      required double absFee}) async {
    try {
      final res = await ffi.buildTxStaticMethodApi(
          walletId: _liquidWallet,
          sats: sats,
          outAddress: outAddress,
          absFee: absFee);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<PsetAmounts> decode({required String pset}) async {
    try {
      final res = await ffi.decodeTxStaticMethodApi(
          walletId: _liquidWallet, pset: pset);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> sign({
    required Network network,
    required String pset,
    required String mnemonic,
  }) async {
    try {
      final res = await ffi.signTxStaticMethodApi(
        walletId: _liquidWallet,
        network: network,
        pset: pset,
        mnemonic: mnemonic,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> broadcast(
      {required String electrumUrl, required Uint8List txBytes}) async {
    try {
      final res = await ffi.broadcastTxStaticMethodApi(
          electrumUrl: electrumUrl, txBytes: txBytes);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
