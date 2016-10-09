import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:typed_struct/mirrors.dart';

void main() {
  group('$AutoStruct (Animal e2e test)', () {
    e2eTests(([buffer]) => new _Animal$AutoStruct(buffer));
  });
}

typedef Animal AnimalFactory([ByteBuffer buffer]);

void e2eTests(AnimalFactory createAnimal) {
  test('should have a size of 33 bytes (1 uint8 + 32 chars)', () {
    expect(createAnimal().asByteBuffer().lengthInBytes, 33);
  });

  test('should be able to set and retrieve "age"', () {
    var animal = createAnimal();
    expect(animal.age, 0);

    animal.age = 50;
    expect(animal.age, 50);

    var copy = createAnimal(animal.asByteBuffer());
    expect(copy.age, 50);
  });

  test('should be able to set and retrieve "name"', () {
    var animal = createAnimal();
    expect(animal.name, isEmpty);

    animal.name = 'Cat';
    expect(animal.name, 'Cat');

    var copy = createAnimal(animal.asByteBuffer());
    expect(copy.name, 'Cat');
  });
}

@struct
abstract class Animal implements AsByteBuffer {
  @uint8
  int age;

  @Chars(32)
  String name;
}

// An implementation of Animal using AutoStruct.
class _Animal$AutoStruct extends AutoStruct implements Animal {
  _Animal$AutoStruct([ByteBuffer buffer]) : super(buffer);
}
