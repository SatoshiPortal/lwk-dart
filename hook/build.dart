import 'package:flutter_rust_bridge_hooks/flutter_rust_bridge_hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    await const FlutterRustBridgeNativeAssetsBuilder(
      cratePath: 'rust',
      assetName: 'src/generated/frb_generated.io.dart',
      extraCargoBuildArgs: ['--locked'],
    ).run(input: input, output: output);
  });
}
