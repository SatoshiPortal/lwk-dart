import 'package:lwk_dart_example/test_app.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:lwk_dart/lwk_dart.dart' as lwk;

void main() async {
  await lwk.LibLwk.init();
  runApp(const TestApp());
}
