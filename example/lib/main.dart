import 'package:lwk/lwk.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LibLwk.init();
  final ready = (await Descriptor.newConfidentialFromSeed(
    network: LiquidNetwork.mainnet,
    seed: List<int>.filled(64, 0),
  ))
      .ctDescriptor
      .isNotEmpty;
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Liquid Wallet Kit example')),
      body: Center(child: Text(ready ? 'Native library ready' : 'Unavailable')),
    ),
  ));
}
