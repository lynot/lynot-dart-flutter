part of 'input_bloc.dart';

abstract class InputBlocEvent<T> {
  InputBlocEvent(this.value);

  final T value;

  @override
  bool operator ==(dynamic other) {
    return other is InputBlocEvent<T> &&
        (identical(other.value, value) ||
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);
}

class DirtyEvent<T> extends InputBlocEvent<T> {
  DirtyEvent(T value) : super(value);
}

class PureEvent<T> extends InputBlocEvent<T> {
  PureEvent(T value) : super(value);
}

class ValidateEvent<T> extends InputBlocEvent<T> {
  ValidateEvent(T value) : super(value);
}

class _DirectValueEvent<T> extends InputBlocEvent<T> {
  _DirectValueEvent(T value, this.error) : super(value);

  String? error;
}
