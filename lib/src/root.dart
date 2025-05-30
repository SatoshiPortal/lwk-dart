import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:lwk/lwk.dart';
// import 'package:lwk/src/generated/api/types.dart';
// import 'package:lwk/src/generated/api/wallet.dart';
// import 'package:lwk/src/utils/loader.dart';
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

/// List of Balance objects represents a balance of a specific asset
typedef Balances = List<Balance>;

/// Utility class for handling balance-related operations
class BalanceUtils {
  /// Returns the balance amount for a specific asset ID from a list of balances
  ///
  /// [balances] - List of Balance objects to search through
  /// [assetId] - The asset ID to look for
  ///
  /// Returns the balance value if found, or 0 if no matching asset ID is found
  static int getBalanceByAssetId(List<Balance> balances, String assetId) {
    for (var balance in balances) {
      if (balance.assetId == assetId) {
        return balance.value;
      }
    }
    return 0; // Return 0 if no balance is found for the asset ID
  }

  /// Returns the L-BTC balance from a list of balances
  ///
  /// [balances] - List of Balance objects to search through
  ///
  /// Returns the L-BTC balance value if found, or 0 if not found
  static int getLBtcBalance(List<Balance> balances) {
    return getBalanceByAssetId(balances, lBtcAssetId);
  }

  /// Returns the TEST balance from a list of balances
  ///
  /// [balances] - List of Balance objects to search through
  ///
  /// Returns the TEST balance value if found, or 0 if not found
  static int getLTestBalance(List<Balance> balances) {
    return getBalanceByAssetId(balances, lTestAssetId);
  }
}

// Future<String> broadcast({
//   required String electrumUrl,
//   required Uint8List txBytes,
// }) async {
//   try {
//     final res =
//         await LwkWallet.broadcastTx(electrumUrl: electrumUrl, txBytes: txBytes);
//     return res;
//   } catch (e) {
//     rethrow;
//   }
// }
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
