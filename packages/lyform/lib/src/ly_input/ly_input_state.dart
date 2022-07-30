part of 'ly_input.dart';

class LyInputState<T> {
  LyInputState({
    required this.value,
    required this.pureValue,
    required this.lastNotNullValue,
    this.error,
    this.debugName,
  });

  final T value;
  final T pureValue;
  final T lastNotNullValue;
  final String? error;
  final String? debugName;

  @override
  bool operator ==(dynamic other) =>
      (other is LyInputState<T> &&
          (identical(other.value, value) ||
              const DeepCollectionEquality().equals(other.value, value))) &&
      (identical(other.error, error) ||
          const DeepCollectionEquality().equals(other.error, error)) &&
      (identical(other.debugName, debugName) ||
          const DeepCollectionEquality().equals(other.debugName, debugName)) &&
      (identical(other.pureValue, pureValue) ||
          const DeepCollectionEquality().equals(other.pureValue, pureValue)) &&
      (identical(other.lastNotNullValue, lastNotNullValue) ||
          const DeepCollectionEquality()
              .equals(other.lastNotNullValue, lastNotNullValue));

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  String toString() {
    final debugName =
        this.debugName != null ? ', debugName: ${this.debugName}' : '';
    return 'LyInputState($value, $error$debugName)';
  }
}
