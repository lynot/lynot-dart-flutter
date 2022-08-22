part of 'ly_form.dart';

abstract class LyFormState<D, E> extends Equatable {
  const LyFormState(this.inputs);

  final List<LyInputState<dynamic>> inputs;

  @override
  List<Object?> get props => inputs.expand((input) => input.props).toList();
}

class LyFormPureState<D, E> extends LyFormState<D, E> {
  const LyFormPureState(super.inputs);
}

class LyFormInvalidState<D, E> extends LyFormState<D, E> {
  const LyFormInvalidState(super.inputs);
}

class LyFormValidState<D, E> extends LyFormState<D, E> {
  const LyFormValidState(super.inputs);
}

class LyFormLoadingState<D, E> extends LyFormState<D, E> {
  const LyFormLoadingState(super.inputs);
}

class LyFormSuccessState<D, E> extends LyFormState<D, E> {
  const LyFormSuccessState(this.data, super.inputs);

  final D data;

  @override
  List<Object?> get props => [data, ...super.props];
}

class LyFormErrorState<D, E> extends LyFormState<D, E> {
  const LyFormErrorState(this.error, super.inputs);

  final E error;

  @override
  List<Object?> get props => [error, ...super.props];
}
