import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:lwk/lwk.dart';
import 'package:lwk/src/generated/frb_generated.dart';
import 'package:test/test.dart';

void main() {
  final library = Platform.environment['LWK_TEST_LIBRARY'];
  final electrum = Platform.environment['LWK_REGTEST_ELECTRUM'];
  final cli = Platform.environment['LWK_REGTEST_CLI'];
  final datadir = Platform.environment['LWK_REGTEST_DATADIR'];

  test('sync transports changed, unchanged and errors through FFI', () async {
    await LwkCore.init(externalLibrary: ExternalLibrary.open(library!));
    final directory = await Directory.systemTemp.createTemp('lwk-sync-');
    final descriptor = await Descriptor.newConfidentialFromSeed(
        network: LiquidNetwork.regtest, seed: List<int>.filled(64, 1));
    final wallet = await Wallet.init(
        network: LiquidNetwork.regtest,
        dbpath: directory.path,
        descriptor: descriptor);
    Future<bool> sync({int? index}) => wallet.sync_(
        electrumUrl: electrum!, validateDomain: false, stopAtIndex: index);
    Future<String> rpc(List<String> args) async {
      final result = await Process.run(
          cli!, ['-datadir=$datadir', '-chain=liquidregtest', ...args]);
      expect(result.exitCode, 0);
      return (result.stdout as String).trim();
    }

    try {
      expect(await sync(), isTrue);
      expect(await sync(), isFalse);
      expect(await sync(index: 40), isTrue);
      expect(await sync(index: 40), isFalse);
      final address = await rpc(['getnewaddress']);
      await rpc(['generatetoaddress', '1', address]);
      var changed = false;
      for (var i = 0; i < 100 && changed == false; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
        changed = await sync();
      }
      expect(changed, isTrue);
      expect(await sync(), isFalse);
      await expectLater(
          wallet.sync_(
              electrumUrl: 'invalid://localhost', validateDomain: false),
          throwsA(anything));
    } finally {
      wallet.inner.dispose();
      await directory.delete(recursive: true);
    }
  },
      skip: library == null ||
              electrum == null ||
              cli == null ||
              datadir == null
          ? 'requires a native library and an isolated Elements/electrs regtest stack'
          : false);
}
