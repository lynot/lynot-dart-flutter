part of 'form_bloc.dart';

abstract class FormBlocState<D, E> {
  const FormBlocState();

  @override
  String toString() {
    return 'FormBlocState()';
  }
}

class FormPureState<D, E> extends FormBlocState<D, E> {
  const FormPureState() : super();

  @override
  String toString() {
    return 'FormPureState()';
  }
}

class FormInvalidState<D, E> extends FormBlocState<D, E> {
  const FormInvalidState() : super();

  @override
  String toString() {
    return 'FormInvalidState()';
  }
}

class FormValidState<D, E> extends FormBlocState<D, E> {
  const FormValidState() : super();
}

class FormLoadingState<D, E> extends FormBlocState<D, E> {
  const FormLoadingState() : super();

  @override
  String toString() {
    return 'FormLoadingState()';
  }
}

class FormSuccessState<D, E> extends FormBlocState<D, E> {
  const FormSuccessState(this.data) : super();

  final D data;

  @override
  String toString() {
    return 'FormSuccessState($data)';
  }
}

class FormErrorState<D, E> extends FormBlocState<D, E> {
  const FormErrorState(this.error) : super();

  final E error;

  @override
  String toString() {
    return 'FormErrorState($error)';
  }
}
