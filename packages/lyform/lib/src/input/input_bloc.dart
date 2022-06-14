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
    this.debugName,
  })  : validationType = validationType ??
            (validator != null ? ValidationType.always : ValidationType.none),
        validator = validator ?? const EmptyValidator(),
        _lastNotNull = pureValue,
        super(InputBlocState(pureValue, null, debugName)) {
    on<PureEvent<T>>((event, emit) {
      pureValue = event.value;
      emit(InputBlocState<T>(event.value, null, debugName));
    });
    on<InputBlocEvent<T>>((event, emit) {
      if (event.value == pureValue && event.value is! bool) {
        return;
      }
      if (event is DirectValueEvent<T>) {
        emit(InputBlocState<T>(event.value, event.error, debugName));
        return;
      }
      String? error;
      if (validationType == ValidationType.always ||
          (validationType == ValidationType.explicit &&
              event is ValidateEvent<T>)) {
        error = this.validator(event.value);
      }
      error = event.value == pureValue ? null : error;
      emit(InputBlocState<T>(event.value, error, debugName));
    });
  }

  T _lastNotNull;

  T pureValue;
  final BaseValidator<T> validator;
  final ValidationType validationType;
  final String? debugName;

  bool get isPure => pureValue == state.value;
  bool get isValid => state.error == null;
  bool get isInvalid => !isValid;

  T get value => state.value;
  T get lastNotNull => _lastNotNull;

  void dirty(T value) {
    _updateLast(value);
    add(DirtyEvent(value, debugName));
  }

  void pure(T value) {
    _updateLast(value);
    add(PureEvent(value, debugName));
  }

  void validate() {
    if (validationType == ValidationType.always ||
        (validationType == ValidationType.explicit)) {
      final error = validator(value);
      add(DirectValueEvent<T>(state.value, error, debugName));
    }
  }

  void _updateLast(T value) {
    if (value != null) {
      _lastNotNull = value;
    }
  }
}
