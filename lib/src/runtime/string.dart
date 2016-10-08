part of typed_struct.runtime;

/// Annotates a field as a character array.
class Chars extends Field<String> {
  final Encoding _encoding;

  @override
  final int size;

  const Chars(int amount, [this._encoding = UTF8])
      : size = amount * 8,
        super._();

  @override
  String read(ByteData data, int offset) {
    var units = data.buffer.asUint8List(offset, size);
    var i = 0;
    for (; i < units.length; i++) {
      if (units[i] == 0) {
        break;
      }
    }
    units = new Uint8List.view(units.buffer, 0, i);
    return _encoding.decode(units);
  }

  @override
  void write(ByteData data, int offset, String value) {
    data.buffer.asUint8List(offset, size).setAll(0, _encoding.encode(value));
  }
}
