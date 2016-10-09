# Performance

Continuously reading and writing to a typed array is going to be less
efficient then doing mutations and then packaging your data as a struct
before transferring it.

## Options

1. Always read and write directly to `ByteData`
2. Always read and write directly to a class, convert from/to `ByteData`
3. Read and write directly to `ByteData`, but cache reads

## Setting a strategy

```dart
@Strategy
abstract class Animal implements Struct {

}
```
