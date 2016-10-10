library typed_struct.test.e2e_codegen_test;

import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:typed_struct/typed_struct.dart';

import 'e2e_tests.dart';

@Codegen(Animal)
part 'e2e_codegen_test.g.dart';

void main() {
  group('Codegen (Animal e2e test)', () {
    e2eTests(([buffer]) => new _Animal$Struct(buffer));
  });
}
