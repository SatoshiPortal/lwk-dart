import 'dart:io';
import 'dart:typed_data';
// import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:lwk_dart/lwk_dart.dart';
import 'package:lwk_dart/src/generated/api/types.dart';
// import 'package:lwk_dart/src/generated/api/wallet.dart';
import 'package:lwk_dart/src/utils/loader.dart';
// import 'generated/frb_generated.dart';

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

typedef Balances = List<Balance>;

class BalanceUtils {
  static int getBalanceByAssetId(List<Balance> balances, String assetId) {
    for (var balance in balances) {
      if (balance.assetId == assetId) {
        return balance.value;
      }
    }
    return 0; // Return 0 if no balance is found for the asset ID
  }

  static int getLBtcBalance(List<Balance> balances) {
    return getBalanceByAssetId(balances, lBtcAssetId);
  }

  static int getLTestBalance(List<Balance> balances) {
    return getBalanceByAssetId(balances, lTestAssetId);
  }
}

class Wallet extends LwkWallet {
  Wallet._({required super.inner});

  static Future<Wallet> create({
    required Network network,
    required String dbPath,
    required Descriptor descriptor,
    dynamic hint,
  }) async {
    try {
      final res = await LwkWallet.init(
        network: network,
        dbpath: dbPath,
        descriptor: descriptor,
      );
      return Wallet._(inner: res.inner);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sync({required String electrumUrl, hint}) async {
    try {
      final res = await super.sync(
        electrumUrl: electrumUrl,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Address> address({required int index, hint}) async {
    try {
      final res = await super.address(index: index);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Address> addressLastUnused({hint}) async {
    try {
      final res = await super.addressLastUnused();
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> descriptor({hint}) async {
    try {
      final res = await super.descriptor();
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> blindingKey({hint}) async {
    try {
      final res = await super.blindingKey();
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Balances> balances({hint}) async {
    try {
      final res = await super.balances();
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Tx>> txs({hint}) async {
    try {
      final res = await super.txs();
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> buildLbtcTx({
    required int sats,
    required String outAddress,
    required double absFee,
    hint,
  }) async {
    try {
      final res = await super.buildLbtcTx(
        sats: sats,
        outAddress: outAddress,
        absFee: absFee,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> buildAssetTx({
    required int sats,
    required String outAddress,
    required double absFee,
    required String asset,
    required String assetId,
    hint,
  }) async {
    try {
      final res = await super.buildAssetTx(
        sats: sats,
        outAddress: outAddress,
        absFee: absFee,
        asset: asset,
        assetId: assetId,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PsetAmounts> decodeTx({required String pset, hint}) async {
    try {
      final res = await super.decodeTx(
        pset: pset,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> signTx({
    required Network network,
    required String pset,
    required String mnemonic,
    hint,
  }) async {
    try {
      final res = await super.signTx(
        network: network,
        pset: pset,
        mnemonic: mnemonic,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> broadcast({
    required String electrumUrl,
    required Uint8List txBytes,
  }) async {
    try {
      final res = await LwkWallet.broadcastTx(
          electrumUrl: electrumUrl, txBytes: txBytes);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}

// Future<Address> scriptToAddress({
//   required Network network,
//   required String script,
//   String? blindingKey,
// }) async {
//   try {
//     // LwkCore.init();
//     final res = await ffi.addressFromScriptStaticMethodApi(
//       script: script,
//       network: network,
//       blindingKey: blindingKey ?? "",
//     );
//     return res;
//   } catch (e) {
//     rethrow;
//   }
// }

// Future<void> validateAddress({
//   required String address,
// }) async {
//   try {
//     final res = await ffi.validateAddressStaticMethodApi(
//       addressString: address,
//     );
//     return res;
//   } catch (e) {
//     rethrow;
//   }
// }
