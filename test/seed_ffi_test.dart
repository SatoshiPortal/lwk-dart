import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:lwk/lwk.dart';
import 'package:lwk/src/generated/frb_generated.dart';
import 'package:test/test.dart';

/// Crosses the real FFI boundary using the Native Assets build by default.
/// LWK_TEST_LIBRARY optionally selects an explicitly built library.
void main() {
  final library = Platform.environment['LWK_TEST_LIBRARY'];

  group('seed at the FFI boundary', () {
    setUpAll(() async {
      if (library == null) {
        await LibLwk.init();
      } else {
        await LwkCore.init(externalLibrary: ExternalLibrary.open(library));
      }
    });

    test('a seed byte outside 0..255 is rejected, not truncated', () async {
      // Truncated to a byte, 256 would become 0: a valid all-zero seed of another wallet.
      final outOfRange = List<int>.filled(64, 256);
      await expectLater(
        () => Descriptor.newConfidentialFromSeed(
          network: LiquidNetwork.mainnet,
          seed: outOfRange,
        ),
        throwsRangeError,
      );
      await expectLater(
        () => Descriptor.newConfidentialFromSeed(
          network: LiquidNetwork.mainnet,
          seed: List<int>.filled(64, -1),
        ),
        throwsRangeError,
      );
    });

    test('a 64-byte seed crosses the boundary unchanged', () async {
      final asList = await Descriptor.newConfidentialFromSeed(
        network: LiquidNetwork.mainnet,
        seed: List<int>.filled(64, 255),
      );
      final asBytes = await Descriptor.newConfidentialFromSeed(
        network: LiquidNetwork.mainnet,
        seed: Uint8List.fromList(List<int>.filled(64, 255)),
      );
      final zero = await Descriptor.newConfidentialFromSeed(
        network: LiquidNetwork.mainnet,
        seed: Uint8List(64),
      );
      expect(asList, asBytes);
      expect(asList, isNot(zero));
    });
  });
}
