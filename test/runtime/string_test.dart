import 'dart:typed_data';

import 'package:charcode/charcode.dart';
import 'package:test/test.dart';
import 'package:typed_struct/src/runtime.dart';

void main() {
  group('$Chars', () {
    ByteData buffer;

    test('should read and write a string with an offset', () {
      buffer = new ByteData(33);
      final chars = const Chars(32).scope(buffer, 1);
      chars.write('Cat');
      expect(chars.read(), 'Cat');
    });

    test('should read from an existing buffer', () {
      // Create a field of 4 characters.
      const chars = const Chars(4);

      // Create a buffer representing 'abcd'.
      buffer = new ByteData.view(new Uint8List.fromList(const [
        $a,
        $b,
        $c,
        $d,
      ]).buffer);

      // Read from the buffer using the field configuration.
      expect(chars.read(buffer, 0), 'abcd');
    });

    test('should read from an existing buffer that is not full', () {
      // Create a field of 4 characters.
      const chars = const Chars(4);

      // Create a buffer representing 'ab'.
      buffer = new ByteData.view(new Uint8List.fromList(const [
        $a,
        $b,
        $nul,
        $nul,
      ]).buffer);

      // Read from the buffer using the field configuration.
      expect(chars.read(buffer, 0), 'ab');
    });

    test('should write to an existing buffer a non-full string', () {
      // Create a field of 4 characters.
      const chars = const Chars(4);

      // Create a buffer representing 'abcd'.
      buffer = new ByteData.view(new Uint8List.fromList(const [
        $a,
        $b,
        $c,
        $d,
      ]).buffer);

      // Write to the buffer using the field configuration.
      chars.write(buffer, 0, 'ab');

      // Check the buffer again using the field configuration.
      expect(chars.read(buffer, 0), 'ab');

      // Manually assert the buffer has be null-ed out where empty.
      expect(new Uint8List.view(buffer.buffer), [
        $a,
        $b,
        $nul,
        $nul,
      ]);
    });
  });
}
