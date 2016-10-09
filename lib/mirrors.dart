import 'dart:mirrors';
import 'dart:typed_data';

import 'src/runtime.dart';
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
///     abstract class SimpleStruct {
///       factory SimpleStruct() = _AutoSimpleStruct;
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
///     class _AutoSimpleStruct extends AutoStruct implements SimpleStruct {}
abstract class AutoStruct implements AsByteBuffer {
  static final _cachedTotalSize = new Expando<int>();
  static final _cachedFields = new Expando<Map<Symbol, Field>>();

  final Map<Symbol, ScopedField> _scopedFields = <Symbol, ScopedField>{};

  // Memory location for the struct.
  ByteData _buffer;

  /// Initialize a `struct` automatically using `dart:mirrors`.
  AutoStruct([ByteBuffer buffer]) {
    // Get the original class mirror.
    final clazz = reflect(this).type.superinterfaces.first;

    // Compute total amount of space required for this struct, create memory.
    int totalSize = _cachedTotalSize[clazz.reflectedType];
    if (totalSize == null) {
      totalSize = clazz.declarations.values.fold/*<int>*/(0, (size, mirror) {
        final field = _field(mirror);
        return size + (field?.size ?? 0);
      });
      _cachedTotalSize[clazz.reflectedType] = totalSize;
    }

    // Re-use an existing buffer if specified, otherwise create an empty one.
    if (buffer != null) {
      if (buffer.lengthInBytes != totalSize) {
        throw new ArgumentError(
          'Expected buffer of $totalSize, got ${buffer.lengthInBytes}',
        );
      }
      _buffer = new ByteData.view(buffer);
    } else {
      _buffer = new ByteData(totalSize);
    }

    // Create a runtime structure to use to lookup field configuration.
    Map<Symbol, Field> fields = _cachedFields[clazz.reflectedType];
    if (fields == null) {
      fields = <Symbol, Field> {};
      clazz.declarations.forEach((name, mirror) {
        final field = _field(mirror);
        if (field != null) {
          fields[name] = field;
        }
      });
      _cachedFields[clazz.reflectedType] = fields;
    }

    var offset = 0;
    fields.forEach((symbol, field) {
      _scopedFields[symbol] = field.scope(_buffer, offset);
      offset += field.size;
    });
  }

  @override
  ByteBuffer asByteBuffer() => _buffer.buffer;

  @override
  noSuchMethod(Invocation invocation) {
    var memberName = invocation.memberName;
    if (invocation.isAccessor) {
      if (invocation.isSetter) {
        var name = MirrorSystem.getName(memberName);
        name = name.substring(0, name.length - 1);
        memberName = MirrorSystem.getSymbol(name);
      }
      final field = _scopedFields[memberName];
      if (field == null) {
        final method = MirrorSystem.getName(memberName);
        throw new UnsupportedError('Cannot implement "$method"');
      }
      if (invocation.isGetter) {
        return field.read();
      } else {
        return field.write(invocation.positionalArguments.first);
      }
    }
    final method = MirrorSystem.getName(memberName);
    throw new UnsupportedError('Cannot implement "$method"');
  }
}

Field _field(DeclarationMirror field) {
  final metadata = field.metadata
      .where((mirror) {
        return mirror.reflectee is Field;
      })
      .map/*<Field>*/((mirror) => mirror.reflectee)
      .toList(growable: false);
  if (metadata.length > 1) {
    final name = MirrorSystem.getName(field.simpleName);
    final line = field.location.line;
    final col = field.location.column;
    throw new FormatException(
      '$name: Must have exactly one field annotation {$line:$col}',
      field.location.sourceUri.toString(),
    );
  }
  return metadata.isEmpty ? null : metadata.first;
}
