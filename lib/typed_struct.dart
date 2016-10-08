import 'dart:typed_data';

/// Model c-like structs in Dart backed by the `dart:typed_data` library.
///
/// Use `@struct` to annotate a `class` element for code generation:
///     library simple_struct;
///
///     import 'package:struct/typed_struct.dart';
///
///     // Where your struct is generated.
///     part 'simple_struct.g.dart';
///
///     abstract class SimpleStruct implements Struct {
///       factory SimpleStruct() = $SimpleStruct;
///
///       @int8
///       int myChar;
///
///       @int16
///       int myShort;
///
///       @int32
///       int myInt;
///     }
///
/// See `package:struct/mirrors.dart` for a simple implementation using mirrors.
abstract class Struct {
  /// Backing buffer.
  ByteBuffer get buffer;

  /// Sets the backing [buffer].
  set buffer(ByteBuffer buffer);
}

/// A 8-bit (character).
const int8 = const FixedInt._(8);

/// A 16-bit integer (short).
const int16 = const FixedInt._(16);

/// A 32-bit integer.
const int32 = const FixedInt._(32);

/// A fixed-size integer decorator, such as [int8], [int16], [int32].
class FixedInt {
  /// Number of bytes.
  final int bytes;

  const FixedInt._(this.bytes);
}
