import 'dart:io';

import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'artifacts_provider.dart';
import 'builder.dart';
import 'cargo.dart';
import 'crate_hash.dart';
import 'options.dart';
import 'precompile_binaries.dart';
import 'rustup.dart';
import 'target.dart';

final _log = Logger('reproduce_binaries');

class ReproduceBinaries {
  ReproduceBinaries({
    required this.manifestDir,
    required this.targets,
    this.androidSdkLocation,
    this.androidNdkVersion,
    this.androidMinSdkVersion,
    this.precompiledBinariesOverride,
    this.tempDir,
    this.keepTemp = false,
  });

  final String manifestDir;
  final List<Target> targets;
  final String? androidSdkLocation;
  final String? androidNdkVersion;
  final int? androidMinSdkVersion;
  final PrecompiledBinaries? precompiledBinariesOverride;
  final String? tempDir;
  final bool keepTemp;

  Future<void> run() async {
    final crateInfo = CrateInfo.load(manifestDir);
    final crateOptions = CargokitCrateOptions.load(manifestDir: manifestDir);
    final precompiledBinaries =
        precompiledBinariesOverride ?? crateOptions.precompiledBinaries;
    if (precompiledBinaries == null) {
      throw BuildException(
        'No precompiled_binaries config found in cargokit.yaml. '
        'Set it there or pass --url-prefix and --public-key.',
      );
    }

    final targets = List.of(this.targets);
    if (targets.isEmpty) {
      targets.addAll([
        ...Target.buildableTargets(),
        if (androidSdkLocation != null) ...Target.androidTargets(),
      ]);
    }
    if (targets.isEmpty) {
      throw BuildException('No reproducible build targets selected.');
    }

    final hash = CrateHash.compute(manifestDir);
    stdout.writeln('Crate hash: $hash');
    stdout.writeln('Targets: ${targets.map((e) => e.rust).join(', ')}');

    final workDir = tempDir != null
        ? Directory(tempDir!)
        : Directory.systemTemp.createTempSync('cargokit_reproduce_');
    workDir.createSync(recursive: true);

    final deleteTemp = tempDir == null && !keepTemp;
    final failures = <String>[];
    try {
      final buildEnvironment = BuildEnvironment(
        configuration: BuildConfiguration.release,
        crateOptions: crateOptions,
        targetTempDir: workDir.path,
        manifestDir: manifestDir,
        crateInfo: crateInfo,
        isAndroid: androidSdkLocation != null,
        androidSdkPath: androidSdkLocation,
        androidNdkVersion: androidNdkVersion,
        androidMinSdkVersion: androidMinSdkVersion,
      );

      final rustup = Rustup();
      for (final target in targets) {
        stdout.writeln('Building ${target.rust}...');
        final builder = RustBuilder(
          target: target,
          environment: buildEnvironment,
        );
        builder.prepare(rustup);
        final artifactDir = await builder.build();

        final artifacts = getArtifactNames(
          target: target,
          libraryName: crateInfo.packageName,
          remote: true,
        );

        for (final artifact in artifacts) {
          final failure = await _reproduceArtifact(
            artifactDir: artifactDir,
            artifactName: artifact,
            target: target,
            crateHash: hash,
            precompiledBinaries: precompiledBinaries,
          );
          if (failure != null) {
            failures.add(failure);
          }
        }
      }
    } finally {
      if (deleteTemp) {
        _log.fine('Deleting ${workDir.path}');
        workDir.deleteSync(recursive: true);
      } else {
        stdout.writeln('Build artifacts kept in ${workDir.path}');
      }
    }

    if (failures.isNotEmpty) {
      stderr.writeln('');
      stderr.writeln('Reproducibility check failed:');
      for (final failure in failures) {
        stderr.writeln('- $failure');
      }
      throw BuildException('${failures.length} artifact(s) did not reproduce');
    }

    stdout.writeln('All checked binaries reproduced byte-for-byte.');
  }

  Future<String?> _reproduceArtifact({
    required String artifactDir,
    required String artifactName,
    required Target target,
    required String crateHash,
    required PrecompiledBinaries precompiledBinaries,
  }) async {
    final localPath = path.join(artifactDir, artifactName);
    final localFile = File(localPath);
    final remoteFileName = PrecompileBinaries.fileName(target, artifactName);
    final remoteSignatureFileName =
        PrecompileBinaries.signatureFileName(target, artifactName);

    stdout.write('  $remoteFileName... ');
    stdout.flush();

    if (!localFile.existsSync()) {
      stdout.writeln('MISSING LOCAL');
      return '${target.rust}/$artifactName: missing local artifact at '
          '$localPath';
    }

    final prefix = precompiledBinaries.uriPrefix;
    final remoteUrl = Uri.parse('$prefix$crateHash/$remoteFileName');
    final signatureUrl =
        Uri.parse('$prefix$crateHash/$remoteSignatureFileName');

    final signature = await _get(signatureUrl);
    if (signature.statusCode != 200) {
      stdout.writeln('MISSING SIGNATURE');
      return '${target.rust}/$artifactName: signature download failed '
          '(${signature.statusCode}) $signatureUrl';
    }

    final remote = await _get(remoteUrl);
    if (remote.statusCode != 200) {
      stdout.writeln('MISSING REMOTE');
      return '${target.rust}/$artifactName: binary download failed '
          '(${remote.statusCode}) $remoteUrl';
    }

    if (!verify(
      precompiledBinaries.publicKey,
      remote.bodyBytes,
      signature.bodyBytes,
    )) {
      stdout.writeln('INVALID SIGNATURE');
      return '${target.rust}/$artifactName: signature verification failed';
    }

    final localBytes = localFile.readAsBytesSync();
    if (!const ListEquality<int>().equals(localBytes, remote.bodyBytes)) {
      stdout.writeln('MISMATCH');
      return '${target.rust}/$artifactName: local '
          '${localBytes.length} bytes/${_sha256(localBytes)} != remote '
          '${remote.bodyBytes.length} bytes/${_sha256(remote.bodyBytes)}';
    }

    stdout.writeln('OK ${localBytes.length} bytes ${_sha256(localBytes)}');
    return null;
  }

  static String _sha256(List<int> bytes) {
    return hex.encode(sha256.convert(bytes).bytes);
  }

  static Future<Response> _get(Uri url) async {
    Object? lastError;
    for (var attempt = 1; attempt <= 3; attempt++) {
      try {
        return await get(url);
      } on SocketException catch (e) {
        lastError = e;
        _log.warning(
          'Download failed ($attempt/3), retrying $url: ${e.message}',
        );
        await Future.delayed(Duration(seconds: attempt));
      }
    }
    throw BuildException('Download failed for $url: $lastError');
  }
}
