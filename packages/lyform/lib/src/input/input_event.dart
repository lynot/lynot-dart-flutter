part of 'input_bloc.dart';

abstract class InputBlocEvent<T> {
  InputBlocEvent(this.value, [this.debugName]);

  final T value;
  final String? debugName;

  @override
  bool operator ==(dynamic other) {
    return other is InputBlocEvent<T> &&
        (identical(other.value, value) ||
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  String toString() {
    final _debugName = debugName != null ? ', debugName: $debugName' : '';
    return 'InputBlocEvent($value$_debugName)';
  }
}

class DirtyEvent<T> extends InputBlocEvent<T> {
  DirtyEvent(super.value, [super.debugName]);

  @override
  String toString() {
    final _debugName = debugName != null ? ', debugName: $debugName' : '';
    return 'DirtyEvent($value,$_debugName)';
  }
}

class PureEvent<T> extends InputBlocEvent<T> {
  PureEvent(super.value, [super.debugName]);

  @override
  String toString() {
    final _debugName = debugName != null ? ', debugName: $debugName' : '';
    return 'PureEvent($value$_debugName)';
  }
}

class ValidateEvent<T> extends InputBlocEvent<T> {
  ValidateEvent(super.value, [super.debugName]);

  @override
  String toString() {
    final _debugName = debugName != null ? ', debugName: $debugName' : '';
    return 'ValidateEvent($value$_debugName)';
  }
}

class DirectValueEvent<T> extends InputBlocEvent<T> {
  DirectValueEvent(T value, this.error, [String? debugName])
      : super(value, debugName);

  String? error;

  @override
  String toString() {
    final _debugName = debugName != null ? ', debugName: $debugName' : '';
    return 'DirectValueEvent($value, $error$_debugName)';
  }
}
