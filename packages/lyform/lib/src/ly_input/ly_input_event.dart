part of 'ly_input.dart';

abstract class LyInputEvent<T> extends Equatable {
  const LyInputEvent();

  @override
  List<Object?> get props => [];
}

class LyInputPureEvent<T> extends LyInputEvent<T> {
  const LyInputPureEvent(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

class LyInputDirtyEvent<T> extends LyInputEvent<T> {
  const LyInputDirtyEvent(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

class LyInputValidateEvent<T> extends LyInputEvent<T> {
  const LyInputValidateEvent();
}
