part of 'ly_form.dart';

abstract class LyFormState<D, E> {
  const LyFormState(this.inputs);

  final Iterable<LyInput<dynamic>> inputs;

  @override
  String toString() => 'LyFormState()';

  @override
  bool operator ==(dynamic other) =>
      other is LyFormState<D, E> &&
      const DeepCollectionEquality().equals(
        other.inputs,
        inputs,
      );

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(inputs);
}

class LyFormPureState<D, E> extends LyFormState<D, E> {
  const LyFormPureState(super.inputs);

  @override
  String toString() => 'LyFormPureState()';
}

class LyFormInvalidState<D, E> extends LyFormState<D, E> {
  const LyFormInvalidState(super.inputs);

  @override
  String toString() => 'LyFormInvalidState()';
}

class LyFormValidState<D, E> extends LyFormState<D, E> {
  const LyFormValidState(super.inputs);

  @override
  String toString() => 'LyFormValidState()';
}

class LyFormLoadingState<D, E> extends LyFormState<D, E> {
  const LyFormLoadingState(super.inputs);

  @override
  String toString() => 'LyFormLoadingState()';
}

class LyFormSuccessState<D, E> extends LyFormState<D, E> {
  const LyFormSuccessState(this.data, super.inputs);

  final D data;

  @override
  String toString() => 'LyFormSuccessState($data)';

  @override
  bool operator ==(dynamic other) =>
      other is LyFormSuccessState<D, E> &&
      const DeepCollectionEquality().equals(
        other.data,
        data,
      ) &&
      const DeepCollectionEquality().equals(
        other.inputs,
        inputs,
      );

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(inputs);
}

class LyFormErrorState<D, E> extends LyFormState<D, E> {
  const LyFormErrorState(this.error, super.inputs);

  final E error;

  @override
  String toString() => 'LyFormErrorState($error)';

  @override
  bool operator ==(dynamic other) =>
      other is LyFormErrorState<D, E> &&
      const DeepCollectionEquality().equals(
        other.error,
        error,
      ) &&
      const DeepCollectionEquality().equals(
        other.inputs,
        inputs,
      );

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(inputs);
}
