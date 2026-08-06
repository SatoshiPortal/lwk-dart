import 'dart:io';

void replaceOnce(String path, String before, String after) {
  final file = File(path);
  final source = file.readAsStringSync();
  if (!source.contains(before)) {
    throw StateError('Expected flutter_rust_bridge output not found in $path');
  }
  if (source.indexOf(before) != source.lastIndexOf(before)) {
    throw StateError('Expected exactly one match in $path');
  }
  file.writeAsStringSync(source.replaceFirst(before, after));
}

void replaceExactly(String path, String before, String after, int count) {
  final file = File(path);
  final source = file.readAsStringSync();
  final matches = before.allMatches(source).length;
  if (matches != count) {
    throw StateError('Expected $count matches in $path, found $matches');
  }
  file.writeAsStringSync(source.replaceAll(before, after));
}

void main() {
  const ioPath = 'lib/src/generated/frb_generated.io.dart';
  const webPath = 'lib/src/generated/frb_generated.web.dart';

  replaceOnce(
    ioPath,
    "import 'frb_generated.dart';",
    "import 'frb_generated.dart';\nimport '../checked_u64.dart';",
  );
  replaceExactly(
    ioPath,
    'return raw.toSigned(64).toInt();',
    'return checkedU64ToNativeInt(raw);',
    2,
  );

  replaceOnce(
    webPath,
    "import 'frb_generated.dart';",
    "import 'frb_generated.dart';\nimport '../checked_u64.dart';",
  );
  replaceOnce(
    webPath,
    '''JSAny cst_encode_u_64(BigInt raw) {
    // Codec=Cst (C-struct based), see doc to use other codecs
    return castNativeBigInt(raw);
  }''',
    '''JSAny cst_encode_u_64(BigInt raw) {
    // Codec=Cst (C-struct based), see doc to use other codecs
    return castNativeBigInt(checkedU64(raw));
  }''',
  );
  replaceOnce(
    webPath,
    '''JSAny cst_encode_usize(BigInt raw) {
    // Codec=Cst (C-struct based), see doc to use other codecs
    return castNativeBigInt(raw);
  }''',
    '''JSAny cst_encode_usize(BigInt raw) {
    // Codec=Cst (C-struct based), see doc to use other codecs
    return castNativeBigInt(checkedU64(raw));
  }''',
  );
}
