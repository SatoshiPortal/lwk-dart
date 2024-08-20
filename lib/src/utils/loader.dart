import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:http/http.dart' as http;
import 'package:lwk_dart/lwk_dart.dart';

import '../generated/frb_generated.dart';

const name = "liblwkbridge";

class Dylib {
  static Map<String, dynamic>? _config;
  static String get libName => "unittest.liblwk.${_config!['TAG_VERSION']}";
  static String get remoteUrl =>
      "${_config!['REPOSITORY_URL']}${_config!['TAG_VERSION']}/$libName.zip";
  static Future<void> _loadJsonAsset() async {
    final String content = await rootBundle
        .loadString("packages/lwk_dart/assets/release.config.txt");
    Map<String, dynamic> configMap = {};
    List<String> lines = content.split('\n');

    for (String line in lines) {
      List<String> keyVal = line.split('=');
      if (keyVal.length == 2) {
        String key = keyVal[0].trim();
        dynamic value = keyVal[1].trim();
        configMap[key] = value;
      }
    }
    _config = configMap;
  }

  static Future<void> downloadUnitTestDylib(String currentDirectory) async {
    await _loadJsonAsset();
    final assetsDir = '$currentDirectory/build/unit_test_assets';
    if (!(await Directory('$assetsDir/$libName').exists())) {
      try {
        final response = await http.get(Uri.parse(remoteUrl));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final archive = ZipDecoder().decodeBytes(Uint8List.fromList(bytes));
          for (final file in archive) {
            final filename = '$assetsDir/${file.name}';
            if (file.isFile) {
              final fileContent = await File(filename).create(recursive: true);
              await fileContent.writeAsBytes(file.content);
            } else {
              await Directory(filename).create(recursive: true);
            }
          }
        } else {
          print('Download failed: status code ${response.statusCode}!');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static String _getUniTestDylibDir(Directory currentDirectory) {
    final assetsDir = '${currentDirectory.path}/build/unit_test_assets';

    if (Platform.isMacOS) {
      return "$assetsDir/$name.dylib";
    } else if (Platform.isLinux) {
      return "$assetsDir/$name.so";
    } else {
      throw Exception("not support platform:${Platform.operatingSystem}");
    }
  }

  static ExternalLibrary getDylib() {
    if (Platform.environment['FLUTTER_TEST'] == 'true') {
      try {
        return ExternalLibrary.open(_getUniTestDylibDir(Directory.current));
      } catch (e) {
        throw Exception("Unable to open the unit test dylib!");
      }
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return ExternalLibrary.open("$name.a");
    } else if (Platform.isAndroid) {
      return ExternalLibrary.open("$name.so");
    } else if (Platform.isLinux) {
      return ExternalLibrary.open("$name.so");
    } else {
      throw Exception("not support platform:${Platform.operatingSystem}");
    }
  }
}

class LibLwk {
  static Future<void> init() async {
    try {
      if (!LwkCore.instance.initialized) {
        await LwkCore.init(externalLibrary: Dylib.getDylib());
      }
    } catch (e) {
      throw Exception("Failed to initialize lwk: $e");
    }
  }
}
