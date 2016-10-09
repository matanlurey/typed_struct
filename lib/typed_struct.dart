import 'dart:typed_data';

// Runtime API that is re-used as annotations for fields.
export 'src/runtime.dart'
    show Chars, int8, int16, int32, int64, uint8, uint16, uint32, uint64;

/// `C`-like structs in Dart backed by efficient data structures for transfer.
///
/// Annotate a class with `@struct` to implement an `abstract class`:
///     library animal;
///
///     import 'package:typed_struct/typed_struct.dart';
///
///     // Where your struct is generated when using compiled code generation.
///     part 'animal.g.dart';
///
///     @struct
///     abstract class Animal {
///       /// Create a new [Animal], optionally from a byte [buffer].
///       ///
///       /// Redirects to a generated class from `animal.g.dart`.
///       factory Animal([ByteBuffer buffer]) = _Animal$Struct;
///
///       @uint8
///       int age;
///
///       @Chars(32)
///       String name;
///     }
const struct = const _Struct();

class _Struct {
  const _Struct();
}

/// Optional: annotate a `part` directive where to generate code for [struct]:
///     @Codegen(Animal)
///     part 'struct.g.dart';
class Codegen {
  final Type struct;

  const Codegen(this.struct);
}

/// Optional interface for making [ByteBuffer] encoding part of the public API.
abstract class AsByteBuffer {
  ByteBuffer asByteBuffer();
}
