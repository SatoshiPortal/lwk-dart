// ignore_for_file: avoid_print

import 'package:lwk_dart/src/generated/bridge_definitions.dart';
import 'package:lwk_dart/src/root.dart';
import 'package:test/test.dart';

void main() {
  group('Wallet', () {
    test('Wallet Flow', () async {
      const mnemonic =
          "bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon";
      const network = Network.Testnet;
      const electrumUrl = 'blockstream.info:465';
      const dbPath = '/tmp/lwk-darti';
      const outAmount = 10000;
      const outAddress =
          "tlq1qqt4hjkl6sug5ld89sdaekt7ew04va8w7c63adw07l33vcx86vpj5th3w7rkdnckmfpraufnnrfcep4thqt6024phuav99djeu";
      const absFee = 300.0;
      final descriptor = await Descriptor.create(network: network, mnemonic: mnemonic,);
      final wallet = await Wallet.create(
         network: network, dbPath: dbPath, descriptor: descriptor.descriptor, );
      await wallet.sync(electrumUrl);
      final address = await wallet.address();
      print(address);
      // print(wallet.descriptor());
      final balance = await wallet.balance();
      print('Pre Balance: ${balance.lbtc}');
      final txs = await wallet.txs();
      for (final tx in txs){
        print('${tx.txid}:${tx.amount}');
      }
      final pset = await wallet.build(
          sats: outAmount, outAddress: outAddress, absFee: absFee);
      final decodedPset = await wallet.decode(pset: pset);
      print("Amount: ${decodedPset.balances.lbtc} , Fee: ${decodedPset.fee}");
      final signedTxBytes =
          await wallet.sign(network: network, pset: pset, mnemonic: mnemonic);
      final tx = await wallet.broadcast(
          electrumUrl: electrumUrl, txBytes: signedTxBytes);
      print(tx);
      await wallet.sync(electrumUrl);
      final postBalance = await wallet.balance();
      print('Post Balance: ${postBalance.lbtc}');
    });
  });
}
