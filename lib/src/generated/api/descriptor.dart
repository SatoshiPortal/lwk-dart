// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.9.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'types.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `fmt`

/// Wallet descriptor class used to create a new wallet
class Descriptor {
  final String ctDescriptor;

  const Descriptor({
    required this.ctDescriptor,
  });

  /// Createa new wpkh confidential descriptor based on Slip77 blinding key derivation
  static Future<Descriptor> newConfidential(
          {required Network network, required String mnemonic}) =>
      LwkCore.instance.api.crateApiDescriptorDescriptorNewConfidential(
          network: network, mnemonic: mnemonic);

  @override
  int get hashCode => ctDescriptor.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Descriptor &&
          runtimeType == other.runtimeType &&
          ctDescriptor == other.ctDescriptor;
}
