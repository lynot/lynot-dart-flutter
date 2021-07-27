import 'package:collection/collection.dart';
import 'package:bloc/bloc.dart';

part 'input_states.dart';
part 'input_event.dart';

typedef String? InputValidator<T>(T value);

enum ValidationType {
  none,
  explicit,
  always,
}

class InputBloc<T> extends Bloc<InputBlocEvent<T>, InputBlocState<T>> {
  final List<InputValidator<T>> validators;

  T pureValue;
  final ValidationType validationType;

  InputBloc({
    required this.pureValue,
    ValidationType? validationType,
    this.validators = const [],
  })  : this.validationType = validationType ??
            (validators.length > 0
                ? ValidationType.always
                : ValidationType.none),
        super(InputBlocState(pureValue));

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
      emit(InputBlocState<T>(state.value, error));
    }
  }

  String? _findError(T value) {
    return validators.fold(
        null, (previousValue, validator) => previousValue ?? validator(value));
  }

  @override
  Stream<InputBlocState<T>> mapEventToState(event) async* {
    if (event is PureEvent) {
      pureValue = event.value;
    }

    String? error;

    if (validationType == ValidationType.always ||
        (validationType == ValidationType.explicit && event is ValidateEvent))
      error = _findError(event.value);

    error = event.value == pureValue ? null : error;

    yield InputBlocState<T>(event.value, error);
  }
}
