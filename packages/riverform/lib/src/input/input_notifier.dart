import 'dart:async';

import 'package:async/async.dart';
import 'package:riverform/riverform.dart';
import 'package:riverpod/riverpod.dart';

class InputNotifier<T> extends StateNotifier<InputStateData<T>> {
  InputNotifier({
    required this.ref,
    required this.formId,
    required T value,
    this.initialValue,
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

  final Ref ref;

  final String formId;

  final InputValidator<T> Function(Ref ref, String formId)? validatorBuilder;

  final InputValidationMode validationMode;

  final T? initialValue;

  /// Reset the notifier with a new Pure value
  void reset() {
    state = InputStateData(
      value: initialValue,
      initialValue: initialValue,
      error: null,
      validState: InputValidState.unknow,
    );

    if (validationMode == InputValidationMode.implicit) {
      validate();
    }
  }

  void update(T value) {
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

  // return true if completes and no error
  Future<bool> validate() async {
    if (validatorBuilder == null) {
      state = InputStateData(
        value: state.value,
        initialValue: state.initialValue,
        error: null,
        validState: InputValidState.valid,
      );
      return true;
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
    final validator = validatorBuilder!.call(ref, formId);
    validationProcess =
        CancelableOperation.fromFuture(validator.validate(state.value));

    final error = await validationProcess!.valueOrCancellation('CANCELED');

    if (error != 'CANCELED') {
      state = InputStateData(
        value: state.value,
        initialValue: state.initialValue,
        error: error,
        validState:
            error == null ? InputValidState.valid : InputValidState.invalid,
      );
      return error == null;
    }

    return false;
  }
}
