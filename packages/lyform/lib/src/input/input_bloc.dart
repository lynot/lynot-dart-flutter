import 'package:collection/collection.dart';
import 'package:bloc/bloc.dart';

part 'input_states.dart';
part 'input_event.dart';

typedef E? InputValidator<T, E>(T value);

enum ValidationType {
  none,
  explicit,
  always,
}

class InputBloc<T, E> extends Bloc<InputBlocEvent<T>, InputBlocState<T, E>> {
  final List<InputValidator<T, E>> validators;

  T pureValue;
  final ValidationType validationType;

  InputBloc(
      {required this.pureValue,
      this.validationType = ValidationType.always,
      this.validators = const []})
      : super(InputBlocState(pureValue));

  bool get isPure => pureValue == state.value;
  bool get isValid => !isPure && state.error == null;
  bool get isInvalid => !isValid;

  void dirty(T value) {
    add(DirtyEvent(value));
  }

  void pure(T value) {
    add(PureEvent(value));
  }

  void validate() {
    if (validationType == ValidationType.always ||
        (validationType == ValidationType.explicit)) {
      final error = isPure ? null : _findError(state.value);
      emit(InputBlocState<T, E>(state.value, error));
    }
  }

  E? _findError(T value) {
    return validators.fold(
        null, (previousValue, validator) => previousValue ?? validator(value));
  }

  @override
  Stream<InputBlocState<T, E>> mapEventToState(event) async* {
    if (event is PureEvent) {
      pureValue = event.value;
    }

    E? error;

    if (validationType == ValidationType.always ||
        (validationType == ValidationType.explicit && event is ValidateEvent))
      error = _findError(event.value);

    error = event.value == pureValue ? null : error;

    yield InputBlocState<T, E>(event.value, error);
  }
}
