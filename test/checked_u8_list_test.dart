import 'dart:typed_data';

import 'package:lwk/src/checked_u8_list.dart';
import 'package:test/test.dart';

void main() {
  test('checkedU8List accepts every byte value', () {
    final bytes = List<int>.generate(256, (i) => i);
    expect(checkedU8List(bytes), bytes);
    final typed = Uint8List.fromList(bytes);
    expect(identical(checkedU8List(typed), typed), isTrue);
  });

  test('checkedU8List rejects values that would be truncated to a byte', () {
    expect(() => checkedU8List([0, 256]), throwsRangeError);
    expect(() => checkedU8List([-1]), throwsRangeError);
  });
}
