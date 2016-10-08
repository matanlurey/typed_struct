import 'dart:typed_data';

import 'package:typed_struct/mirrors.dart';
import 'package:test/test.dart';

/// An example struct.
abstract class SimpleStruct implements Struct {
  /// Create a new struct.
  factory SimpleStruct() = _AutoSimpleStruct;

  /// A single character.
  @uint8
  int myChar;

  /// A short integer.
  @uint16
  int myShort;

  /// An integer.
  @uint32
  int myInt;
}

class _AutoSimpleStruct extends AutoStruct implements SimpleStruct {}

void main() {
  group('$AutoStruct', () {
    test('should work for a simple use case', () {
      var simple = new SimpleStruct();
      simple.myChar = 'a'.codeUnitAt(0);
      simple.myShort = 12;
      simple.myInt = 34567;

      expect(new String.fromCharCode(simple.myChar), 'a');
      expect(simple.myShort, 12);
      expect(simple.myInt, 34567);
    });

    test('should be loadable from an existing buffer', () {
      var simple = new SimpleStruct();
      simple.buffer = new Uint8List.fromList([
        97,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        12,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        135,
        7,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ]).buffer;
      expect(new String.fromCharCode(simple.myChar), 'a');
      expect(simple.myShort, 12);
      expect(simple.myInt, 34567);
    });
  });
}
