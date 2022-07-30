part of 'ly_form.dart';

abstract class LyFormEvent {
  const LyFormEvent();

  @override
  String toString() => 'LyFormEvent()';
}

class LyFormAddInputsEvent extends LyFormEvent {
  const LyFormAddInputsEvent(this.inputs);

  final List<LyInput> inputs;

  @override
  String toString() => 'LyFormAddInputsEvent()';
}

class LyFormAddInputEvent extends LyFormEvent {
  const LyFormAddInputEvent(this.index, this.input);

  final int index;
  final LyInput input;

  @override
  String toString() => 'LyFormAddInputEvent()';
}

class LyFormRemoveInputEvent extends LyFormEvent {
  const LyFormRemoveInputEvent(this.index);

  final int index;

  @override
  String toString() => 'LyFormRemoveInputEvent()';
}

class LyFormChangedEvent extends LyFormEvent {
  const LyFormChangedEvent(this.debugName) : super();

  final String? debugName;

  @override
  String toString() {
    final _debugName = debugName == null ? '' : 'debugName: $debugName';
    return 'LyFormChangedEvent($_debugName)';
  }
}

class LyFormResetEvent extends LyFormEvent {
  const LyFormResetEvent() : super();

  @override
  String toString() => 'LyFormResetEvent()';
}

class LyFormSubmitEvent extends LyFormEvent {
  const LyFormSubmitEvent() : super();

  @override
  String toString() => 'LyFormSubmitEvent()';
}
