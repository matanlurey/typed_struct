import 'dart:mirrors';
import 'dart:typed_data';

import 'typed_struct.dart';
export 'typed_struct.dart';

/// A struct implementation that uses `dart:mirrors` at runtime.
///
/// Useful for experimenting with the concept of a struct without setting up
/// code generation or for use on the VM where reflection is not a concern.
///
/// __Example use__:
///     import 'package:typed_struct/mirrors.dart';
///
///     @struct
///     abstract class SimpleStruct {
///       factory SimpleStruct() = _SimpleStructImpl;
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
///     class _SimpleStructImpl extends MirrorsStruct implements SimpleStruct {}
abstract class MirrorsStruct implements Struct {
  ByteData _buffer;
  Map<Symbol, _FixedIntField> _fields = <Symbol, _FixedIntField>{};

  /// Initializes a mirrors-based [Struct].
  MirrorsStruct() {
    final mirror = reflect(this).type.superinterfaces.first;
    var totalSize = 0;
    mirror.declarations.forEach((name, mirror) {
      FixedInt type = mirror.metadata.firstWhere((mirror) {
        return mirror.reflectee is FixedInt;
      }, orElse: () => null)?.reflectee;
      if (type == null) {
        return;
      }
      _fields[name] = new _FixedIntField(totalSize, name, type);
      totalSize += type.bytes;
    });
    if (totalSize == 0) {
      throw new UnsupportedError('At least one annotated field is required');
    }
    _buffer = new ByteData(totalSize);
  }

  @override
  ByteBuffer get buffer => _buffer.buffer;

  @override
  set buffer(ByteBuffer buffer) {
    _buffer = new ByteData.view(buffer);
  }

  @override
  noSuchMethod(Invocation invocation) {
    final memberNameEq = MirrorSystem.getSymbol(
        MirrorSystem.getName(invocation.memberName).replaceAll('=', ''));
    if (invocation.isAccessor && _fields.containsKey(memberNameEq)) {
      if (invocation.isGetter) {
        return _get(_fields[invocation.memberName]);
      }
      final value = invocation.positionalArguments.first;
      return _set(_fields[memberNameEq], value);
    }
  }

  _get(_FixedIntField field) {
    switch (field.type) {
      case int8:
        return _buffer.getUint8(field.offset);
      case int16:
        return _buffer.getUint16(field.offset);
      case int32:
        return _buffer.getUint32(field.offset);
    }
  }

  _set(_FixedIntField field, value) {
    switch (field.type) {
      case int8:
        _buffer.setUint8(field.offset, value);
        break;
      case int16:
        _buffer.setUint16(field.offset, value);
        break;
      case int32:
        _buffer.setUint32(field.offset, value);
        break;
    }
  }
}

class _FixedIntField {
  final int offset;
  final Symbol name;
  final FixedInt type;

  _FixedIntField(this.offset, this.name, this.type);
}
