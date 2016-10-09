import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:typed_struct/mirrors.dart';

import 'e2e_tests.dart';

void main() {
  group('$AutoStruct (Animal e2e test)', () {
    e2eTests(([buffer]) => new _Animal$AutoStruct(buffer));
  });
}

// An implementation of Animal using AutoStruct.
class _Animal$AutoStruct extends AutoStruct implements Animal {
  _Animal$AutoStruct([ByteBuffer buffer]) : super(buffer);
}
