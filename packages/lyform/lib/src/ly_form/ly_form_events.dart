part of 'ly_form.dart';

abstract class LyFormEvent extends Equatable {
  const LyFormEvent();
}

class LyFormAddInputsEvent extends LyFormEvent {
  const LyFormAddInputsEvent(this.inputs);

  final List<LyInput<dynamic>> inputs;

  @override
  List<Object?> get props =>
      inputs.expand((input) => input.state.props).toList();
}

class LyFormAddInputEvent extends LyFormEvent {
  const LyFormAddInputEvent(this.index, this.input);

  final int index;
  final LyInput input;

  @override
  List<Object?> get props => [index, ...input.state.props];
}

class LyFormRemoveInputEvent extends LyFormEvent {
  const LyFormRemoveInputEvent(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class LyFormChangedEvent extends LyFormEvent {
  const LyFormChangedEvent(this.debugName);

  final String? debugName;

  @override
  List<Object?> get props => [debugName];
}

class LyFormResetEvent extends LyFormEvent {
  const LyFormResetEvent();

  @override
  List<Object?> get props => [];
}

class LyFormSubmitEvent extends LyFormEvent {
  const LyFormSubmitEvent();

  @override
  List<Object?> get props => [];
}
