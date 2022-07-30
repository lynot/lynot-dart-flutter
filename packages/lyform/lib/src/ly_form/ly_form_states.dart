part of 'ly_form.dart';

abstract class LyFormState<D, E> {
  const LyFormState();

  @override
  String toString() => 'LyFormState()';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LyFormState;

  @override
  int get hashCode => runtimeType.hashCode;
}

class LyFormPureState<D, E> extends LyFormState<D, E> {
  const LyFormPureState();

  @override
  String toString() => 'LyFormPureState()';
}

class LyFormInvalidState<D, E> extends LyFormState<D, E> {
  const LyFormInvalidState();

  @override
  String toString() => 'LyFormInvalidState()';
}

class LyFormValidState<D, E> extends LyFormState<D, E> {
  const LyFormValidState();

  @override
  String toString() => 'LyFormValidState()';
}

class LyFormLoadingState<D, E> extends LyFormState<D, E> {
  const LyFormLoadingState();

  @override
  String toString() => 'LyFormLoadingState()';
}

class LyFormSuccessState<D, E> extends LyFormState<D, E> {
  const LyFormSuccessState(this.data);

  final D data;

  @override
  String toString() => 'LyFormSuccessState($data)';

  @override
  bool operator ==(Object other) =>
      other is LyFormSuccessState<D, E> && identical(data, other.data);

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);
}

class LyFormErrorState<D, E> extends LyFormState<D, E> {
  const LyFormErrorState(this.error);

  final E error;

  @override
  String toString() => 'LyFormErrorState($error)';

  @override
  bool operator ==(Object other) =>
      other is LyFormErrorState<D, E> && identical(error, other.error);

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);
}
