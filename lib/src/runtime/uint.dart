part of typed_struct.runtime;

/// Annotates a field as an unsigned integer.
abstract class UnsignedInt extends Field<int> {
  const UnsignedInt._() : super._();
}

/// 8-bit unsigned integer, such as a character.
const UnsignedInt uint8 = const _Uint8();

/// 16-bit unsigned integer, sometimes called a short.
const UnsignedInt uint16 = const _Uint16();

/// 32-bit unsigned integer, sometimes just called an int.
const UnsignedInt uint32 = const _Uint32();

/// 64-bit unsigned integer, sometimes called a long integer.
const UnsignedInt uint64 = const _Uint64();

class _Uint8 extends UnsignedInt {
  @override
  final int size = 1;

  const _Uint8() : super._();

  @override
  int read(ByteData data, int offset) => data.getUint8(offset);

  @override
  void write(ByteData data, int offset, int value) {
    data.setUint8(offset, value);
  }
}

class _Uint16 extends UnsignedInt {
  @override
  final int size = 2;

  const _Uint16() : super._();

  @override
  int read(ByteData data, int offset) => data.getUint16(offset);

  @override
  void write(ByteData data, int offset, int value) {
    data.setUint16(offset, value);
  }
}

class _Uint32 extends UnsignedInt {
  @override
  final int size = 4;

  const _Uint32() : super._();

  @override
  int read(ByteData data, int offset) => data.getUint32(offset);

  @override
  void write(ByteData data, int offset, int value) {
    data.setUint32(offset, value);
  }
}

class _Uint64 extends UnsignedInt {
  @override
  final int size = 8;

  const _Uint64() : super._();

  @override
  int read(ByteData data, int offset) => data.getUint64(offset);

  @override
  void write(ByteData data, int offset, int value) {
    data.setUint64(offset, value);
  }
}
