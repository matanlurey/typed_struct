import 'dart:typed_data';

/// Model c-like structs in Dart backed by the `dart:typed_data` library.
///
/// Implement [Struct] to annotate a `class` element for code generation:
///     library simple_struct;
///
///     import 'package:typed_struct/typed_struct.dart';
///
///     // Where your struct is generated.
///     part 'simple_struct.g.dart';
///
///     abstract class SimpleStruct implements Struct {
///       factory SimpleStruct() = _SimpleStruct$Generated;
///
///       @uint8
///       int myChar;
///
///       @uint16
///       int myShort;
///
///       @uint32
///       int myInt;
///     }
///
/// See `package:struct/mirrors.dart` for a simple implementation using mirrors.
abstract class Struct {
  /// Backing buffer of the struct that can used and sent efficiently.
  ByteBuffer get buffer;

  /// Sets the backing [buffer] of the struct.
  set buffer(ByteBuffer buffer);
}
