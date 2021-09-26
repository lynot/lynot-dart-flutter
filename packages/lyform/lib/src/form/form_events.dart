part of 'form_bloc.dart';

abstract class FormBlocEvent {
  const FormBlocEvent();

  @override
  String toString() {
    return 'FormBlocEvent()';
  }
}

class FormChangedEvent extends FormBlocEvent {
  const FormChangedEvent() : super();

  @override
  String toString() {
    return 'FormChangedEvent()';
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

class _FormSubmitEvent extends FormBlocEvent {
  const _FormSubmitEvent() : super();

  @override
  String toString() {
    return '_FormSubmitEvent()';
  }
}
