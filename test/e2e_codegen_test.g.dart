// A representative idea of what code generation should output.
part of typed_struct.test.e2e_codegen_test;

class _Animal$Struct implements Animal {
  static const int totalSize = 33;

  final ByteData _buffer;

  _Animal$Struct([ByteBuffer buffer])
      : _buffer = buffer != null ? new ByteData.view(buffer) : new ByteData(totalSize) {
    assert(() {
      if (_buffer.lengthInBytes != totalSize) {
        throw new ArgumentError(
          'Expected buffer of $totalSize, got ${buffer.lengthInBytes}',
        );
      }
      return true;
    });
  }

  @override
  int get age => uint8.read(_buffer, 0);

  @override
  set age(int age) {
    uint8.write(_buffer, 0, age);
  }

  @override
  String get name => const Chars(32).read(_buffer, 1);

  @override
  set name(String name) {
    const Chars(32).write(_buffer, 1, name);
  }

  @override
  ByteBuffer asByteBuffer() => _buffer.buffer;
}
