part of 'ly_form.dart';

abstract class LyFormState<D, E> {
  const LyFormState();

  @override
  String toString() {
    return 'LyFormState()';
  }
}

class LyFormPureState<D, E> extends LyFormState<D, E> {
  const LyFormPureState() : super();

  @override
  String toString() {
    return 'LyFormPureState()';
  }
}

class LyFormInvalidState<D, E> extends LyFormState<D, E> {
  const LyFormInvalidState() : super();

  @override
  String toString() {
    return 'LyFormInvalidState()';
  }
}

class LyFormValidState<D, E> extends LyFormState<D, E> {
  const LyFormValidState() : super();
  @override
  String toString() {
    return 'LyFormValidState()';
  }
}

class LyFormLoadingState<D, E> extends LyFormState<D, E> {
  const LyFormLoadingState() : super();

  @override
  String toString() {
    return 'LyFormLoadingState()';
  }
}

class LyFormSuccessState<D, E> extends LyFormState<D, E> {
  const LyFormSuccessState(this.data) : super();

  final D data;

  @override
  String toString() {
    return 'LyFormSuccessState($data)';
  }
}

class LyFormErrorState<D, E> extends LyFormState<D, E> {
  const LyFormErrorState(this.error) : super();

  final E error;

  @override
  String toString() {
    return 'LyFormErrorState($error)';
  }
}
