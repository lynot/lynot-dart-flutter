import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

part 'input_event.dart';
part 'input_states.dart';
part 'input_validator.dart';
part 'validation_type.dart';

class InputBloc<T> extends Bloc<InputBlocEvent<T>, InputBlocState<T>> {
  InputBloc({
    required this.pureValue,
    ValidationType? validationType,
    BaseValidator<T>? validator,
    @Deprecated("Use 'validator' instead of 'validators'")
        List<InputValidator<T>> validators = const [],
  })  : validationType = validationType ??
            (validator != null || validators.isNotEmpty
                ? ValidationType.always
                : ValidationType.none),
        validator =
            (validator ?? const EmptyValidator()) & ListValidator(validators),
        super(InputBlocState(pureValue)) {
    on<PureEvent<T>>((event, emit) {
      pureValue = event.value;
    });
    on<InputBlocEvent<T>>((event, emit) {
      if (event is DirectValueEvent<T>) {
        emit(InputBlocState<T>(event.value, event.error));
        return;
      }
      String? error;
      if (validationType == ValidationType.always ||
          (validationType == ValidationType.explicit &&
              event is ValidateEvent<T>)) {
        error = this.validator(event.value);
      }
      error = event.value == pureValue ? null : error;
      emit(InputBlocState<T>(event.value, error));
    });
  }

  T pureValue;
  final BaseValidator<T> validator;
  final ValidationType validationType;

  bool get isPure => pureValue == state.value;
  bool get isValid => state.error == null;
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
      final error = validator(value);
      add(DirectValueEvent<T>(state.value, error));
    }
  }
}
