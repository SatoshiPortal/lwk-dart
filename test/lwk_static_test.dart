import 'package:lwk_dart/src/generated/bridge_definitions.dart';
import 'package:lwk_dart/src/utils/loader.dart';
import 'package:test/test.dart';

void main() {
  group('COMMON', () {
    test('Create Descriptor', () async {
      final mnemonic = "bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon";
      final network = LiquidNetwork.Testnet;
      // final desc = await ffi.kcreateDescriptorStaticMethodApi(mnemonic, network);
      // print('$desc');
    });
  });
}