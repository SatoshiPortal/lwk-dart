import 'package:flutter/material.dart';
import 'package:lwk_dart/lwk_dart.dart';
import 'package:path_provider/path_provider.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  static Future<String> getTempDirectory() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      final directory = await getTemporaryDirectory();
      final path = "${directory.path}/lwk-test";
      return path;
    } catch (e) {
      print('Error getting current directory: $e');
      throw (e);
    }
  }

  static Future<String> getNewAddress() async {
    const mnemonic =
        "bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon";
    const network = LiquidNetwork.Testnet;
    const electrumUrl = 'blockstream.info:465';

    final dbPath = await getTempDirectory();
    const outAmount = 10000;
    const outAddress =
        "tlq1qqt4hjkl6sug5ld89sdaekt7ew04va8w7c63adw07l33vcx86vpj5th3w7rkdnckmfpraufnnrfcep4thqt6024phuav99djeu";
    const absFee = 300.0;

    final wallet = await LiquidWallet.create(
        mnemonic: mnemonic, network: network, dbPath: dbPath);
    await wallet.sync(electrumUrl);
    final address = await wallet.address();
    return address;
  }

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  String newAddress = "<new-address>";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18.0),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll<Color>(Colors.red.shade400),
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade400,
          title: Text("LWK Flutter Lib Test:"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  final res = await TestApp.getNewAddress();
                  setState(() {
                    newAddress = res;
                  });
                },
                child: const Text(
                  'Create new Address',
                ),
              ),
              Text(newAddress),
            ],
          ),
        ),
      ),
    );
  }
}
