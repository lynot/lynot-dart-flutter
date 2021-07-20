part of 'form_bloc.dart';

abstract class FormBlocEvent {
  const FormBlocEvent();
}

class FormChangedEvent extends FormBlocEvent {
  const FormChangedEvent() : super();
}

class FormSubmitEvent extends FormBlocEvent {
  const FormSubmitEvent() : super();
}
