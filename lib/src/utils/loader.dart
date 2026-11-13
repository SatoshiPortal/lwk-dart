import 'dart:ffi' as ffi;

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart'
    show ExternalLibrary;

import '../generated/frb_generated.dart';

class LibLwk {
  static Future<void> init() async {
    if (!LwkCore.instance.initialized) {
      await LwkCore.init(externalLibrary: _NativeAssetLibrary());
    }
  }
}

// FRB 2.13's generated wire reads these two fields from ExternalLibrary.
class _NativeAssetLibrary implements ExternalLibrary {
  @override
  final ffi.DynamicLibrary ffiDynamicLibrary = ffi.DynamicLibrary.codeAsset(
    'package:lwk/src/generated/frb_generated.io.dart',
  );

  @override
  final String debugInfo = 'Native Assets: lwk';
}
