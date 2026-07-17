import 'package:lwk/lwk.dart';

/// Number of confirmed L-BTC UTXOs in the wallet.
Future<int> confirmedLbtcUtxoCount(
  Wallet wallet, {
  required String lbtcAssetId,
}) async {
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

Future<List<String>> batchBroadcast({
  required List<String> signedPsets,
  required String electrumUrl,
}) async {
  final txids = <String>[];
  for (final s in signedPsets) {
    txids.add(await Blockchain.broadcastSignedPset(
      electrumUrl: electrumUrl,
      signedPset: s,
    ));
  }
  return txids;
}
