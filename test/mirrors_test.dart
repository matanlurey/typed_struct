import 'dart:typed_data';

import 'package:typed_struct/mirrors.dart';
import 'package:test/test.dart';

/// An example struct.
abstract class SimpleStruct implements Struct {
  /// Create a new struct.
  factory SimpleStruct() = _SimpleStructImpl;

  /// A single character.
  @int8
  int myChar;

  /// A short integer.
  @int16
  int myShort;

  /// An integer.
  @int32
  int myInt;
}

class _SimpleStructImpl extends MirrorsStruct implements SimpleStruct {}

void main() {
  group('$MirrorsStruct', () {
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
