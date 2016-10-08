import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:typed_struct/src/runtime.dart';

void main() {
  test('$Chars', () {
    var buffer = new ByteData(32 * 8);
    var chars = const Chars(32);
    chars.write(buffer, 0, 'Hello World');
    expect(chars.read(buffer, 0), 'Hello World');
  });
}
