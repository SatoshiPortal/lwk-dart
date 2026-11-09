import 'dart:typed_data';

/// Returns [bytes] unchanged if every element fits in a byte.
///
/// The generated codec copies a `List<int>` into a byte buffer, which keeps only the low
/// 8 bits of each element: 256 would cross the FFI boundary as 0.
List<int> checkedU8List(List<int> bytes) {
  if (bytes is Uint8List) return bytes;
  for (var i = 0; i < bytes.length; i++) {
    final byte = bytes[i];
    if (byte < 0 || byte > 255) {
      throw RangeError.range(byte, 0, 255, 'bytes[$i]');
    }
  }
  return bytes;
}
