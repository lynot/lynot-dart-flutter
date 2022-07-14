part of 'input_bloc.dart';

abstract class InputBaseState<T> {
  InputBaseState({
    required this.value,
    this.error,
    this.debugName,
  });

  final T value;
  final String? error;
  final String? debugName;
}

class InputCubitState<T> extends InputBaseState<T> {
  InputCubitState({
    required super.value,
    required this.pureValue,
    required this.lastNotNullValue,
    super.error,
    super.debugName,
  });

  final T pureValue;
  final T lastNotNullValue;

  @override
  bool operator ==(dynamic other) {
    return (other is InputCubitState<T> &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value))) &&
        (identical(other.error, error) ||
            const DeepCollectionEquality().equals(other.error, error)) &&
        (identical(other.debugName, debugName) ||
            const DeepCollectionEquality()
                .equals(other.debugName, debugName)) &&
        (identical(other.pureValue, pureValue) ||
            const DeepCollectionEquality()
                .equals(other.pureValue, pureValue)) &&
        (identical(other.lastNotNullValue, lastNotNullValue) ||
            const DeepCollectionEquality()
                .equals(other.lastNotNullValue, lastNotNullValue));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  String toString() {
    final _debugName = debugName != null ? ', debugName: $debugName' : '';
    return 'InputCubitState($value, $error$_debugName)';
  }
}

class InputBlocState<T> extends InputBaseState<T> {
  InputBlocState(T value, [String? error, String? debugName])
      : super(value: value, error: error, debugName: debugName);

  @override
  bool operator ==(dynamic other) {
    return (other is InputBlocState<T> &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value))) &&
        (identical(other.error, error) ||
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  String toString() {
    final _debugName = debugName != null ? ', debugName: $debugName' : '';
    return 'InputBlocState($value, $error$_debugName)';
  }
}
