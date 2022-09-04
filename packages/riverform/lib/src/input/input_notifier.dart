import 'dart:async';

import 'package:async/async.dart';
import 'package:riverform/riverform.dart';
import 'package:riverpod/riverpod.dart';

class InputNotifier<T> extends StateNotifier<InputStateData<T>> {
  InputNotifier({
    required this.read,
    required this.formId,
    required T? initialValue,
    required T? value,
    this.validatorBuilder,
    this.validationMode = InputValidationMode.implicit,
  }) : super(
          InputStateData(
            value: value,
            initialValue: initialValue,
            error: null,
            validState: InputValidState.unknow,
          ),
        ) {
    if (validationMode == InputValidationMode.implicit) {
      validate();
    }
  }

  final Reader read;

  final String formId;

  final InputValidator<T> Function(Reader read, String formId)?
      validatorBuilder;

  final InputValidationMode validationMode;

  /// Reset the notifier with a new Pure value
  void reset(T? initialValue) {
    state = InputStateData(
      value: state.value,
      initialValue: initialValue,
      error: state.error,
      validState: state.validState,
    );

    // Dont need to call validate here because change the initialValue do not change validation
  }

  void update(T? value) {
    if (value == state.value) return;

    state = InputStateData(
      value: value,
      initialValue: state.initialValue,
      error: null,
      validState: InputValidState.unknow,
    );

    invalidateValidation();
  }

  void invalidateValidation() {
    state = InputStateData(
      value: state.value,
      initialValue: state.initialValue,
      error: null,
      validState: InputValidState.unknow,
    );

    if (validationMode == InputValidationMode.implicit) {
      validate();
    }
  }

  CancelableOperation<String?>? validationProcess;

  Future<void> validate() async {
    if (validatorBuilder == null) {
      state = InputStateData(
        value: state.value,
        initialValue: state.initialValue,
        error: null,
        validState: InputValidState.valid,
      );
      return;
    }

    state = InputStateData(
      value: state.value,
      initialValue: state.initialValue,
      error: state.error,
      validState: InputValidState.checking,
    );

    // cancel previous checking process
    if (validationProcess != null) {
      await validationProcess?.cancel();
    }
    final validator = validatorBuilder!.call(read, formId);
    validationProcess =
        CancelableOperation.fromFuture(validator.validate(state.value)).then(
      (error) {
        state = InputStateData(
          value: state.value,
          initialValue: state.initialValue,
          error: error,
          validState:
              error == null ? InputValidState.valid : InputValidState.invalid,
        );
        return null;
      },
    );
  }
}
