part of 'input_bloc.dart';

class InputBlocState<T> {
  final T value;
  final String? error;

  InputBlocState(this.value, [this.error]);

  bool operator ==(dynamic other) {
    return (other is InputBlocState<T> &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value))) &&
        (identical(other.error, value) ||
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);
}
