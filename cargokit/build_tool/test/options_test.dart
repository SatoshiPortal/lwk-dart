import 'package:build_tool/src/builder.dart';
import 'package:build_tool/src/options.dart';
import 'package:hex/hex.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('parseCargoBuildOptions', () {
    final yaml = """
toolchain: nightly
extra_flags:
  - -Z
  # Comment here
  - build-std=panic_abort,std
""";
    final node = loadYamlNode(yaml);
    final options = CargoBuildOptions.parse(node);
    expect(options.toolchain, Toolchain.nightly);
    expect(options.flags, ['-Z', 'build-std=panic_abort,std']);
  });

  test('parsePrecompiledBinaries', () {
    final yaml = """
url_prefix: https://url-prefix
public_key: a4c3433798eb2c36edf2b94dbb4dd899d57496ca373a8982d8a792410b7f6445
""";
    final precompiledBinaries = PrecompiledBinaries.parse(loadYamlNode(yaml));
    final key = HEX.decode(
        'a4c3433798eb2c36edf2b94dbb4dd899d57496ca373a8982d8a792410b7f6445');
    expect(precompiledBinaries.uriPrefix, 'https://url-prefix');
    expect(precompiledBinaries.publicKey.bytes, key);
  });

  test('parseCargokitOptions', () {
    const yaml = '''
cargo:
  # For smalles binaries rebuilt the standard library with panic=abort
  debug:
    toolchain: nightly
    extra_flags:
      - -Z
      # Comment here
      - build-std=panic_abort,std
  release:
    toolchain: beta

precompiled_binaries:
  url_prefix: https://url-prefix
  public_key: a4c3433798eb2c36edf2b94dbb4dd899d57496ca373a8982d8a792410b7f6445
''';
    final options = CargokitCrateOptions.parse(loadYamlNode(yaml));
    expect(options.precompiledBinaries?.uriPrefix, 'https://url-prefix');
    final key = HEX.decode(
        'a4c3433798eb2c36edf2b94dbb4dd899d57496ca373a8982d8a792410b7f6445');
    expect(options.precompiledBinaries?.publicKey.bytes, key);

    final debugOptions = options.cargo[BuildConfiguration.debug]!;
    expect(debugOptions.toolchain, Toolchain.nightly);
    expect(debugOptions.flags, ['-Z', 'build-std=panic_abort,std']);

    final releaseOptions = options.cargo[BuildConfiguration.release]!;
    expect(releaseOptions.toolchain, Toolchain.beta);
    expect(releaseOptions.flags, []);
  });

  test('parseCargoBuildOptions with pinned version', () {
    final yaml = """
toolchain: 1.95.0
""";
    final options = CargoBuildOptions.parse(loadYamlNode(yaml));
    expect(options.toolchain.name, '1.95.0');
    expect(options.toolchain.isNightly, false);
    expect(options.flags, isEmpty);
  });

  test('parseCargoBuildOptions with dated nightly', () {
    final yaml = """
toolchain: nightly-2025-10-01
""";
    final options = CargoBuildOptions.parse(loadYamlNode(yaml));
    expect(options.toolchain.name, 'nightly-2025-10-01');
    expect(options.toolchain.isNightly, true);
  });

  test('parseCargoBuildOptions rejects empty toolchain', () {
    final yaml = """
toolchain: ""
""";
    expect(() => CargoBuildOptions.parse(loadYamlNode(yaml)),
        throwsA(isA<SourceSpanException>()));
  });

  test('Toolchain equality and channel constants', () {
    expect(Toolchain.stable.name, 'stable');
    expect(Toolchain.nightly.isNightly, true);
    expect(const Toolchain('1.95.0') == const Toolchain('1.95.0'), true);
    expect(const Toolchain('1.95.0').isNightly, false);
    expect(Toolchain.tryParse('stable'), Toolchain.stable);
    expect(Toolchain.tryParse('1.95.0')?.name, '1.95.0');
    expect(Toolchain.tryParse(''), isNull);
    expect(Toolchain.tryParse('has space'), isNull);
    expect(Toolchain.tryParse('weird?char'), isNull);
  });

  test('parseCargokitUserOptions', () {
    const yaml = '''
use_precompiled_binaries: false
verbose_logging: true
''';
    final options = CargokitUserOptions.parse(loadYamlNode(yaml));
    expect(options.usePrecompiledBinaries, false);
    expect(options.verboseLogging, true);
  });
}
