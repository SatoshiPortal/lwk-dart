import 'package:lwk_example/test_app.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:lwk/lwk.dart' as lwk;

void main() async {
  await lwk.LibLwk.init();
  runApp(const TestApp());
}
