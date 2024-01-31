import 'dart:ffi';
import 'dart:io' show Platform;

import '../generated/bindings.dart';

// export 'bridge_definitions.dart';
// export 'bridge_generated.dart';

final _api = DynamicLibrary.open(
  './test/liblwkdart${Platform.operatingSystem == 'linux' ? '.so' : '.dylib'}',
);
final ffi = LwkDartImpl(_api);