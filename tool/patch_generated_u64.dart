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

void insertInputCheck(String path, String method, String argument) {
  final file = File(path);
  final source = file.readAsStringSync();
  final pattern = RegExp(
    r'Future<String>\s+' + RegExp.escape(method) + r'\([^)]*\)\s*\{',
  );
  final matches = pattern.allMatches(source).toList();
  if (matches.length != 1) {
    throw StateError('Expected exactly one implementation of $method in $path');
  }
  final end = matches.single.end;
  file.writeAsStringSync(
    source.replaceRange(end, end, '\n    checkedU8List($argument);'),
  );
}

void main() {
  const dartPath = 'lib/src/generated/frb_generated.dart';
  const ioPath = 'lib/src/generated/frb_generated.io.dart';
  const webPath = 'lib/src/generated/frb_generated.web.dart';

  // A byte-list codec check is too late if earlier arguments allocated.
  // Validate the complete input before the handler can encode any argument.
  replaceOnce(
    dartPath,
    "import 'frb_generated.dart';",
    "import 'frb_generated.dart';\nimport '../checked_u8_list.dart';",
  );
  insertInputCheck(
    dartPath,
    'crateApiBlockchainBlockchainBroadcastTxBytes',
    'txBytes',
  );
  insertInputCheck(dartPath, 'crateApiWalletWalletSignTxWithSeed', 'seed');
  insertInputCheck(
    dartPath,
    'crateApiWalletWalletSignedPsetWithExtraDetailsWithSeed',
    'seed',
  );

  replaceOnce(
    ioPath,
    "import 'frb_generated.dart';",
    "import 'frb_generated.dart';\nimport '../checked_u64.dart';\nimport '../checked_u8_list.dart';",
  );
  // Byte-list arguments are `List<int>`: the codec keeps only the low 8 bits.
  // Check before allocating, or the native buffer leaks when the check throws.
  replaceOnce(
    ioPath,
    '''final ans = wire.cst_new_list_prim_u_8_loose(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);''',
    '''final bytes = checkedU8List(raw);
    final ans = wire.cst_new_list_prim_u_8_loose(bytes.length);
    ans.ref.ptr.asTypedList(bytes.length).setAll(0, bytes);''',
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
    "import 'frb_generated.dart';\nimport '../checked_u64.dart';\nimport '../checked_u8_list.dart';",
  );
  replaceOnce(
    webPath,
    '''JSAny cst_encode_list_prim_u_8_loose(List<int> raw) {
    // Codec=Cst (C-struct based), see doc to use other codecs
    return raw.jsify()!;
  }''',
    '''JSAny cst_encode_list_prim_u_8_loose(List<int> raw) {
    // Codec=Cst (C-struct based), see doc to use other codecs
    return checkedU8List(raw).jsify()!;
  }''',
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
