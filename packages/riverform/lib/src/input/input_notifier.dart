import 'dart:async';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:riverform/src/input/input_state_type.dart';
import 'package:riverform/src/input/input_validation_mode.dart';
import 'package:riverform/src/input/input_validator.dart';
import 'package:riverpod/riverpod.dart';

class InputNotifier<T> extends StateNotifier<InputState<T>> {
  InputNotifier(
    this.read, {
    T? value,
    this.initialValue,
    this.validatorBuilder,
    this.validationMode = InputValidationMode.implicit,
  }) : super(InputState(
            type: initialValue == value
                ? InputStateType.pure
                : InputStateType.unknow,
            value: value)) {
    if (validationMode == InputValidationMode.implicit) {
      validate();
    }
  }
  final T? initialValue;

  final Reader read;

  final InputValidator<T> Function(Reader read)? validatorBuilder;

  final InputValidationMode validationMode;

  void update(T? value) {
    if (value == state.value) return;

    if (value == initialValue) {
      state = InputState(
        type: InputStateType.pure,
        value: value,
        error: null,
      );
    } else {
      // Set to unknow state, but conserve the error
      state = InputState(
        type: InputStateType.unknow,
        value: value,
        error: state.error,
      );
    }

    if (validationMode == InputValidationMode.implicit) {
      validate();
    }
  }

  CancelableOperation<String?>? validationProcess;

  Future<void> validate() async {
    if (validatorBuilder == null) {
      state = InputState(
        type: InputStateType.valid,
        value: state.value,
        error: null,
      );
      return;
    }

    state = InputState(
      type: InputStateType.checking,
      value: state.value,
      error: state.error,
    );

    // cancel previous checking process
    if (validationProcess != null) {
      validationProcess?.cancel();
    }

    final validator = validatorBuilder!(read);

    validationProcess =
        CancelableOperation.fromFuture(validator.validate(state.value)).then(
      (error) {
        log(error ?? 'no error');
        state = InputState(
          type: error == null ? InputStateType.valid : InputStateType.invalid,
          value: state.value,
          error: error,
        );
        return null;
      },
      onError: (p0, p1) {
        log('ERROR!');
        return 'ERROR';
      },
    );
  }
}

class InputState<T> extends Equatable {
  final InputStateType type;
  final String? error;
  final T? value;

  const InputState({
    required this.type,
    this.error,
    required this.value,
  });

  @override
  String toString() {
    return 'state: ${type.name.replaceAll('InputStateType.', '')}, value: $value, error: $error';
  }

  @override
  List<Object?> get props => [type, value, error];
}
