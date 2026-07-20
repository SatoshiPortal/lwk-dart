import 'package:lwk/lwk.dart';

/// Number of confirmed L-BTC UTXOs in the wallet.
///
/// Takes [network] rather than a raw asset-id string so callers can't typo or
/// mismatch mainnet/testnet asset IDs — the correct one is looked up
/// internally via [getLbtcAssetId]/[getLtestAssetId].
Future<int> confirmedLbtcUtxoCount(
  Wallet wallet, {
  required LiquidNetwork network,
}) async {
  final lbtcAssetId =
      network == LiquidNetwork.mainnet ? getLbtcAssetId() : getLtestAssetId();
  final utxos = await wallet.utxos();
  return utxos
      .where((u) => u.unblinded.asset == lbtcAssetId && u.height != null)
      .length;
}

Future<List<String>> batchSign(
  Wallet wallet, {
  required List<String> psets,
  required LiquidNetwork network,
  required String mnemonic,
}) async {
  final signed = <String>[];
  for (final p in psets) {
    signed.add(
        await wallet.signTx(network: network, pset: p, mnemonic: mnemonic));
  }
  return signed;
}

class LiquidBatchBroadcastResult {
  const LiquidBatchBroadcastResult({
    required this.signedPset,
    required this.success,
    this.txid,
    this.error,
  });

  final String signedPset;
  final bool success;
  final String? txid;
  final String? error;
}

Future<List<LiquidBatchBroadcastResult>> batchBroadcast({
  required List<String> signedPsets,
  required String electrumUrl,
}) async {
  final results = <LiquidBatchBroadcastResult>[];
  for (final s in signedPsets) {
    try {
      final txid = await Blockchain.broadcastSignedPset(
        electrumUrl: electrumUrl,
        signedPset: s,
      );
      results.add(LiquidBatchBroadcastResult(
        signedPset: s,
        success: true,
        txid: txid,
      ));
    } catch (e) {
      final message = e is LwkError ? e.msg : e.toString();
      results.add(LiquidBatchBroadcastResult(
        signedPset: s,
        success: false,
        error: message,
      ));
    }
  }
  return results;
}
