import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

part 'input_event.dart';
part 'input_states.dart';

typedef InputValidator<T> = String? Function(T value);

enum ValidationType {
  none,
  explicit,
  always,
}

class InputBloc<T> extends Bloc<InputBlocEvent<T>, InputBlocState<T>> {
  InputBloc({
    required this.pureValue,
    this.isOptional = false,
    ValidationType? validationType,
    this.validators = const [],
  })  : validationType = validationType ??
            (validators.isNotEmpty
                ? ValidationType.always
                : ValidationType.none),
        super(InputBlocState(pureValue)) {
    on<PureEvent<T>>((event, emit) {
      pureValue = event.value;
    });
    on<InputBlocEvent<T>>((event, emit) {
      String? error;
      if (validationType == ValidationType.always ||
          (validationType == ValidationType.explicit &&
              event is ValidateEvent)) {
        error = _findError(event.value);
      }
      error = event.value == pureValue ? null : error;
      emit(InputBlocState<T>(event.value, error));
    });
  }

  final List<InputValidator<T>> validators;
  T pureValue;
  final ValidationType validationType;

  bool isOptional;
  bool get isPure => pureValue == state.value;
  bool get isValid => !isPure && state.error == null || isPure && isOptional;
  bool get isInvalid => !isValid;

  T get value => state.value;

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
}
