import 'dart:ffi';
import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:lwk/lwk.dart';
import 'package:lwk/src/generated/api/wallet.dart' show MutexWollet;
import 'package:lwk/src/generated/frb_generated.dart';
import 'package:lwk/src/generated/frb_generated.io.dart';
import 'package:test/test.dart';

class _UnusedWallet implements MutexWollet {
  @override
  void dispose() {}

  @override
  bool get isDisposed => false;
}

class _DirectHandler extends BaseHandler {
  @override
  Future<S> executeNormal<S, E extends Object>(NormalTask<S, E> task) {
    task.callFfi(0);
    throw StateError('Allocation probe unexpectedly returned');
  }
}

class _CaptureHandler extends BaseHandler {
  late BaseApiImpl api;
  final captured = StateError('Bridge infrastructure captured');

  @override
  Future<S> executeNormal<S, E extends Object>(NormalTask<S, E> task) {
    api = task.apiImpl;
    throw captured;
  }
}

void main() {
  final library = Platform.environment['LWK_TEST_LIBRARY'];
  final symbols = <String>[];
  final allocationAttempt = StateError('Native argument allocation attempted');
  late LwkCoreApiImpl api;
  final wallet = Wallet(inner: _UnusedWallet());

  Pointer<T> lookup<T extends NativeType>(String symbol) {
    symbols.add(symbol);
    throw allocationAttempt;
  }

  group('byte-list validation before native argument allocation', () {
    setUpAll(() async {
      if (library == null) throw StateError('LWK_TEST_LIBRARY is required');
      final capture = _CaptureHandler();
      await LwkCore.init(
        externalLibrary: ExternalLibrary.open(library),
        handler: capture,
      );
      // Capture infrastructure through the public handler before calling FFI.
      expect(
        () => Blockchain.broadcastTxBytes(
          network: LiquidNetwork.testnet,
          electrumUrl: 'unused',
          txBytes: [],
        ),
        throwsA(same(capture.captured)),
      );
      final initialized = capture.api;
      // Reuse initialized bridge infrastructure, but intercept every native symbol lookup before an argument allocator can actually run.
      api = LwkCoreApiImpl(
        handler: _DirectHandler(),
        wire: LwkCoreWire.fromLookup(lookup),
        generalizedFrbRustBinding: initialized.generalizedFrbRustBinding,
        portManager: initialized.portManager,
      );
    });
    tearDownAll(LwkCore.dispose);
    setUp(symbols.clear);

    for (final (name, invoke) in <(String, Future<String> Function(List<int>))>[
      (
        'signTxWithSeed',
        (bytes) => api.crateApiWalletWalletSignTxWithSeed(
              that: wallet,
              network: LiquidNetwork.testnet,
              pset: 'unused',
              seed: bytes,
            )
      ),
      (
        'signedPsetWithExtraDetailsWithSeed',
        (bytes) => api.crateApiWalletWalletSignedPsetWithExtraDetailsWithSeed(
              that: wallet,
              network: LiquidNetwork.testnet,
              pset: 'unused',
              seed: bytes,
            )
      ),
      (
        'broadcastTxBytes',
        (bytes) => api.crateApiBlockchainBlockchainBroadcastTxBytes(
              network: LiquidNetwork.testnet,
              electrumUrl: 'unused',
              txBytes: bytes,
            )
      ),
    ]) {
      for (final invalid in [-1, 256]) {
        test('$name rejects $invalid before any allocation', () {
          expect(() => invoke(List<int>.filled(64, invalid)), throwsRangeError);
          expect(symbols, isEmpty);
        });
      }
      test('$name reaches the allocation probe for valid bytes', () {
        expect(() => invoke(List<int>.filled(64, 0)),
            throwsA(same(allocationAttempt)));
        expect(symbols, hasLength(1));
        expect(symbols.single, startsWith('frbgen_lwk_cst_new_'));
      });
    }
  },
      skip: library == null
          ? 'set LWK_TEST_LIBRARY to this checkout native build'
          : false);
}
