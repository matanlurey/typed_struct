part of typed_struct.runtime;

/// Annotates a field as an unsigned integer.
abstract class Int extends Field<int> {
  const Int._() : super._();
}

/// 8-bit integer, such as a character.
const Int int8 = const _Int8();

/// 16-bit integer, sometimes called a short.
const Int int16 = const _Int16();

/// 32-bit integer, sometimes just called an int.
const Int int32 = const _Int32();

/// 64-bit integer, sometimes called a long integer.
const Int int64 = const _Int64();

class _Int8 extends Int {
  @override
  final int size = 8;

  const _Int8() : super._();

  @override
  int read(ByteData data, int offset) => data.getInt8(offset);

  @override
  void write(ByteData data, int offset, int value) {
    data.setInt8(offset, value);
  }
}

class _Int16 extends Int {
  @override
  final int size = 16;

  const _Int16() : super._();

  @override
  int read(ByteData data, int offset) => data.getInt16(offset);

  @override
  void write(ByteData data, int offset, int value) {
    data.setInt16(offset, value);
  }
}

class _Int32 extends Int {
  @override
  final int size = 32;

  const _Int32() : super._();

  @override
  int read(ByteData data, int offset) => data.getInt32(offset);

  @override
  void write(ByteData data, int offset, int value) {
    data.setInt32(offset, value);
  }
}

class _Int64 extends Int {
  @override
  final int size = 64;

  const _Int64() : super._();

  @override
  int read(ByteData data, int offset) => data.getInt64(offset);

  @override
  void write(ByteData data, int offset, int value) {
    data.setInt64(offset, value);
  }
}
