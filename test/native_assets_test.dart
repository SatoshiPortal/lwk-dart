import 'package:flutter_test/flutter_test.dart';
import 'package:lwk/lwk.dart';
import 'package:lwk/src/generated/frb_generated.dart';

void main() {
  test('loads the hook-built library without a path override', () async {
    await LibLwk.init();
    final first = await Descriptor.newConfidentialFromSeed(
      network: LiquidNetwork.mainnet,
      seed: List<int>.filled(64, 0),
    );
    final second = await Descriptor.newConfidentialFromSeed(
      network: LiquidNetwork.mainnet,
      seed: List<int>.filled(64, 255),
    );
    expect(first.ctDescriptor.isNotEmpty, isTrue);
    expect(first == second, isFalse);
    LwkCore.dispose();
  });
}
