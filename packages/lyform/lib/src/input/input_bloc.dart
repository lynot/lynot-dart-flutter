import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

part 'input_event.dart';
part 'input_states.dart';
part 'input_validator.dart';
part 'validation_type.dart';

abstract class InputBase<T, S extends InputBaseState<T>> extends BlocBase<S> {
  InputBase(super.state);

  bool get isPure => pureValue == state.value;
  bool get isValid => state.error == null;
  bool get isInvalid => !isValid;

  T get value => state.value;
  T get pureValue;
  T get lastNotNullValue;

  void dirty(T value);

  void pure(T value);

  void validate();
}

class InputCubit<T> extends Cubit<InputCubitState<T>>
    implements InputBase<T, InputCubitState<T>> {
  InputCubit({
    required T pureValue,
    ValidationType? validationType,
    BaseValidator<T>? validator,
    this.debugName,
  })  : validationType = validationType ??
            (validator != null ? ValidationType.always : ValidationType.none),
        validator = validator ?? const EmptyValidator(),
        super(
          InputCubitState(
            value: pureValue,
            pureValue: pureValue,
            lastNotNullValue: pureValue,
            debugName: debugName,
          ),
        );

  final BaseValidator<T> validator;
  final ValidationType validationType;
  final String? debugName;

  @override
  bool get isPure => pureValue == state.value;
  @override
  bool get isValid => state.error == null;
  @override
  bool get isInvalid => !isValid;

  @override
  T get value => state.value;
  @override
  T get pureValue => state.pureValue;
  @override
  T get lastNotNullValue => state.lastNotNullValue;

  @override
  void dirty(T value) {
    final pureValue = state.pureValue;
    final lastNotNullValue = value ?? state.lastNotNullValue;
    final error =
        validationType == ValidationType.always ? validator(value) : null;
    final debugName = state.debugName;
    emit(
      InputCubitState<T>(
        value: value,
        pureValue: pureValue,
        lastNotNullValue: lastNotNullValue,
        error: error,
        debugName: debugName,
      ),
    );
  }

  @override
  void pure(T value) {
    final pureValue = value;
    final lastNotNullValue = value ?? state.lastNotNullValue;
    final debugName = state.debugName;
    emit(
      InputCubitState<T>(
        value: value,
        pureValue: pureValue,
        lastNotNullValue: lastNotNullValue,
        debugName: debugName,
      ),
    );
  }

  @override
  void validate() {
    if (validationType != ValidationType.none) {
      final value = state.value;
      final pureValue = state.pureValue;
      final lastNotNullValue = state.lastNotNullValue;
      final error = validator(state.value);
      final debugName = state.debugName;
      emit(
        InputCubitState<T>(
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

class InputBloc<T> extends Bloc<InputBlocEvent<T>, InputBlocState<T>>
    implements InputBase<T, InputBlocState<T>> {
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

    on<DirectValueEvent<T>>((event, emit) {
      emit(InputBlocState<T>(event.value, event.error, debugName));
    });

    on<ValidateEvent<T>>((event, emit) {
      final error = validationType != ValidationType.none
          ? this.validator(event.value)
          : null;
      emit(InputBlocState<T>(event.value, error, debugName));
    });

    on<DirtyEvent<T>>((event, emit) {
      final error = validationType == ValidationType.always
          ? this.validator(event.value)
          : null;
      emit(InputBlocState<T>(event.value, error, debugName));
    });
  }

  T _lastNotNull;

  @override
  T pureValue;
  final BaseValidator<T> validator;
  final ValidationType validationType;
  final String? debugName;

  @override
  bool get isPure => pureValue == state.value;
  @override
  bool get isValid => state.error == null;
  @override
  bool get isInvalid => !isValid;

  @override
  T get value => state.value;
  @override
  T get lastNotNullValue => _lastNotNull;

  @override
  void dirty(T value) {
    _updateLast(value);
    add(DirtyEvent(value, debugName));
  }

  @override
  void pure(T value) {
    _updateLast(value);
    add(PureEvent(value, debugName));
  }

  @override
  void validate() {
    if (validationType != ValidationType.none) {
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
