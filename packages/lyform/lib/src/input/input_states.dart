part of 'input_bloc.dart';

class InputBlocState<T> {
  InputBlocState(this.value, [this.error]);

  final T value;
  final String? error;

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
    return 'InputBlocState($value, $error)';
  }
}
