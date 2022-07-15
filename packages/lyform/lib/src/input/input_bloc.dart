import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

part 'input_event.dart';
part 'input_states.dart';
part 'input_validator.dart';
part 'validation_type.dart';

class InputBloc<T> extends Cubit<InputBlocState<T>> {
  InputBloc({
    required T pureValue,
    ValidationType? validationType,
    BaseValidator<T>? validator,
    this.debugName,
  })  : validationType = validationType ??
            (validator != null ? ValidationType.always : ValidationType.none),
        validator = validator ?? const EmptyValidator(),
        super(
          InputBlocState(
            value: pureValue,
            pureValue: pureValue,
            lastNotNullValue: pureValue,
            debugName: debugName,
          ),
        );

  final BaseValidator<T> validator;
  final ValidationType validationType;
  final String? debugName;

  bool get isPure => pureValue == state.value;
  bool get isValid => state.error == null;
  bool get isInvalid => !isValid;

  T get value => state.value;
  T get pureValue => state.pureValue;
  T get lastNotNullValue => state.lastNotNullValue;

  void dirty(T value) {
    final pureValue = state.pureValue;
    final lastNotNullValue = value ?? state.lastNotNullValue;
    final error = state.error;
    final debugName = state.debugName;
    emit(
      InputBlocState<T>(
        value: value,
        pureValue: pureValue,
        lastNotNullValue: lastNotNullValue,
        error: error,
        debugName: debugName,
      ),
    );
    if (validationType == ValidationType.always) {
      validate();
    }
  }

  void pure(T value) {
    final pureValue = value;
    final lastNotNullValue = value ?? state.lastNotNullValue;
    final debugName = state.debugName;
    emit(
      InputBlocState<T>(
        value: value,
        pureValue: pureValue,
        lastNotNullValue: lastNotNullValue,
        debugName: debugName,
      ),
    );
  }

  void validate() {
    if (validationType != ValidationType.none) {
      final value = state.value;
      final pureValue = state.pureValue;
      final lastNotNullValue = state.lastNotNullValue;
      final error = validator(state.value);
      final debugName = state.debugName;
      emit(
        InputBlocState<T>(
          value: value,
          pureValue: pureValue,
          lastNotNullValue: lastNotNullValue,
          error: error,
          debugName: debugName,
        ),
      );
    }
  }
}
