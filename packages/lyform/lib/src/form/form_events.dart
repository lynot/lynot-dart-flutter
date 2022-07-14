part of 'form_bloc.dart';

abstract class FormBlocEvent {
  const FormBlocEvent();

  @override
  String toString() {
    return 'FormBlocEvent()';
  }
}

class FormStartedEvent extends FormBlocEvent {
  const FormStartedEvent();

  @override
  String toString() {
    return 'FormStartedEvent()';
  }
}

class FormChangedEvent extends FormBlocEvent {
  const FormChangedEvent(this.debugName) : super();

  final String? debugName;

  @override
  String toString() {
    final _debugName = debugName == null ? '' : 'debugName: $debugName';
    return 'FormChangedEvent($_debugName)';
  }
}

class FormResetEvent extends FormBlocEvent {
  const FormResetEvent() : super();

  @override
  String toString() {
    return 'FormResetEvent()';
  }
}

class FormSubmitEvent extends FormBlocEvent {
  const FormSubmitEvent() : super();

  @override
  String toString() {
    return 'FormSubmitEvent()';
  }
}
