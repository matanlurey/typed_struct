part of typed_struct.runtime;

/// Annotates a field as a character array.
class Chars extends Field<String> {
  final Encoding _encoding;

  @override
  final int size;

  const Chars(int amount, [this._encoding = UTF8])
      : size = amount,
        super._();

  @override
  String read(ByteData data, int offset) {
    var units = data.buffer.asUint8List(offset, size);
    int i;
    for (i = offset; i < units.length + offset; i++) {
      if (units[i] == 0) {
        break;
      }
    }
    units = new Uint8List.view(units.buffer, offset, i);
    if (units.length == 1 && units[0] == $nul) {
      return '';
    }
    return _encoding.decode(units);
  }

  @override
  void write(ByteData data, int offset, String value) {
    assert(() {
      if (value.length > size) {
        throw new RangeError.range(value.length, 0, size, 'value');
      }
      return true;
    });
    for (var i = 0; i < value.length; i++) {
      data.setUint8(i + offset, value.codeUnitAt(i));
    }
    for (var i = value.length; i < size; i++) {
      data.setUint8(i + offset, $nul);
    }
  }
}
