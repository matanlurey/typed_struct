// Runtime support for Structs.
//
// This file should not be imported directly.
library typed_struct.runtime;

import 'dart:convert';
import 'dart:typed_data';

import 'package:charcode/charcode.dart';

part 'runtime/int.dart';
part 'runtime/string.dart';
part 'runtime/uint.dart';

/// A helper object that knows how to read and write to a field object.
abstract class Field<T> {
  const Field._();

  /// Create a scoped instance of this field helper to [data] at [offset].
  ScopedField<T> scope(ByteData data, int offset) {
    return new ScopedField<T>._(this, data, offset);
  }

  /// Size of the field in memory.
  int get size;

  /// Read a field from [data] starting at [offset].
  T read(ByteData data, int offset);

  /// Write a field [value] to [data] starting at [offset].
  void write(ByteData data, int offset, T value);
}

/// A scoped helper object to an instance of a class.
class ScopedField<T> {
  final Field<T> _field;
  final ByteData _data;
  final int _offset;

  const ScopedField._(this._field, this._data, this._offset);

  /// Reads a field.
  T read() => _field.read(_data, _offset);

  /// Re-scope an instance of this field helper to [data];
  ScopedField<T> scope(ByteData data) {
    return new ScopedField<T>._(_field, data, _offset);
  }

  /// Writes a field.
  void write(T value) {
    _field.write(_data, _offset, value);
  }
}
