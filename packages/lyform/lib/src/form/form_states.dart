part of 'form_bloc.dart';

abstract class FormBlocState<D, E> {
  const FormBlocState();
}

class FormPureState<D, E> extends FormBlocState<D, E> {
  const FormPureState() : super();
}

class FormInvalidState<D, E> extends FormBlocState<D, E> {
  const FormInvalidState() : super();
}

class FormValidState<D, E> extends FormBlocState<D, E> {
  const FormValidState() : super();
}

class FormLoadingState<D, E> extends FormBlocState<D, E> {
  const FormLoadingState() : super();
}

class FormSuccessState<D, E> extends FormBlocState<D, E> {
  const FormSuccessState(this.data) : super();

  final D data;
}

class FormErrorState<D, E> extends FormBlocState<D, E> {
  const FormErrorState(this.error) : super();

  final E error;
}
