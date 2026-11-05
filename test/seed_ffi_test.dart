import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:lwk/lwk.dart';
import 'package:lwk/src/generated/frb_generated.dart';
import 'package:test/test.dart';

/// Crosses the real FFI boundary, so it needs a native library built from this checkout:
/// `cargo build --manifest-path rust/Cargo.toml` then
/// `LWK_TEST_LIBRARY=rust/target/debug/liblwk.so flutter test test/seed_ffi_test.dart`.
void main() {
  final library = Platform.environment['LWK_TEST_LIBRARY'];

  group('seed at the FFI boundary', () {
    setUpAll(() async {
      await LwkCore.init(externalLibrary: ExternalLibrary.open(library!));
    });

    test('a seed byte outside 0..255 is rejected, not truncated', () async {
      // Truncated to a byte, 256 would become 0: a valid all-zero seed of another wallet.
      final outOfRange = List<int>.filled(64, 256);
      await expectLater(
        () => Descriptor.newConfidentialFromSeed(
            network: LiquidNetwork.mainnet, seed: outOfRange),
        throwsRangeError,
      );
      await expectLater(
        () => Descriptor.newConfidentialFromSeed(
            network: LiquidNetwork.mainnet, seed: List<int>.filled(64, -1)),
        throwsRangeError,
      );
    });

    test('a 64-byte seed crosses the boundary unchanged', () async {
      final asList = await Descriptor.newConfidentialFromSeed(
          network: LiquidNetwork.mainnet, seed: List<int>.filled(64, 255));
      final asBytes = await Descriptor.newConfidentialFromSeed(
          network: LiquidNetwork.mainnet,
          seed: Uint8List.fromList(List<int>.filled(64, 255)));
      final zero = await Descriptor.newConfidentialFromSeed(
          network: LiquidNetwork.mainnet, seed: Uint8List(64));
      expect(asList, asBytes);
      expect(asList, isNot(zero));
    });
  },
      skip: library == null
          ? 'set LWK_TEST_LIBRARY to a native library built from this checkout'
          : false);
}
