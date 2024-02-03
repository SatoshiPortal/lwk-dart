import 'package:lwk_dart/src/generated/bridge_definitions.dart';
import 'package:lwk_dart/src/utils/loader.dart';
import 'package:test/test.dart';

void main() {
  group('Wallet', () {
    test('Wallet Flow', () async {
      const mnemonic =
          "bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon";
      const network = LiquidNetwork.Testnet;
      const electrumUrl = 'blockstream.info:465';
      const dbPath = '/tmp/lwk-dart';
      final wallet = await ffi.newWalletStaticMethodApi(
        mnemonic: mnemonic,
        network: network,
        dbPath: dbPath,
      );
      print('$wallet');

      await ffi.syncStaticMethodApi(electrumUrl: electrumUrl, wallet: wallet);
      final address = await ffi.addressStaticMethodApi(wallet: wallet);
      print('$address');

      final balance = await ffi.balanceStaticMethodApi(wallet: wallet);
      print('$balance');

      final txs = await ffi.txsStaticMethodApi(wallet: wallet);
      txs.forEach((element) {
        print('${element.kind}');
        print('${element.amount}');
        print('${element.txid}');
        print('${element.address}');
        print('---------------------------');
      });
      const outAddress =
          "tlq1qqt4hjkl6sug5ld89sdaekt7ew04va8w7c63adw07l33vcx86vpj5th3w7rkdnckmfpraufnnrfcep4thqt6024phuav99djeu";
      const outAmount = 1000;
      const fee = 300.0;
      final pset = await ffi.buildTxStaticMethodApi(
          wallet: wallet, sats: outAmount, outAddress: outAddress, absFee: fee);

      final decoded =
          await ffi.decodeTxStaticMethodApi(wallet: wallet, pset: pset);
      print('------------CONFIRM TX---------------');
      print('Fee: ${decoded.fee}');
      print('Total: ${decoded.balances.lbtc}');
      print('-------------------------------------');

      final signedTxBytes = await ffi.signTxStaticMethodApi(
          wallet: wallet, network: network, pset: pset, mnemonic: mnemonic);
      final txid = await ffi.broadcastTxStaticMethodApi(
          electrumUrl: electrumUrl, txBytes: signedTxBytes);
      print('$txid');
    });
  });
}
