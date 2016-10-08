# typed_struct

[![Build Status](https://travis-ci.org/matanlurey/typed_struct.svg?branch=master)](https://travis-ci.org/matanlurey/typed_struct)
[![Pub](https://img.shields.io/pub/v/typed_struct.svg)](https://pub.dartlang.org/packages/typed_struct)

Typed data structures in Dart. Loosely based on [js-struct][js-struct].

[js-struct]: https://github.com/toji/js-struct

This package is **in development** and currently can be previewed using
a mirrors-based implementation, and is not suitable for production use
or use within a Flutter or Web binary. The end goal is seamless IPC-like
communication for Isolates, binary data, and more.

## Usage

```dart
import 'package:struct/mirrors.dart';

abstract class SimpleStruct implements Struct {
  factory SimpleStruct() = _SimpleStructImpl;

  @int8
  int myChar;

  @int16
  int myShort;

  @int32
  int myInt;
}

class _SimpleStructImpl extends MirrorsStruct implements SimpleStruct {}

void main() {
  var struct = new SimpleStruct();
  simple.myChar = 'a'.codeUnitAt(0);
  simple.myShort = 12;
  simple.myInt = 34567;
}
```

## How it works

While the user interacts with a `Struct` using getters/setters, behind
the scenes values are read and write to a [ByteBuffer][bb], a sequence
of bytes in memory.

Read [more][more] about typed_arrays in the browser.

[bb]: https://api.dartlang.org/stable/1.19.1/dart-typed_data/dart-typed_data-library.html
[more]: https://www.html5rocks.com/en/tutorials/webgl/typed_arrays/