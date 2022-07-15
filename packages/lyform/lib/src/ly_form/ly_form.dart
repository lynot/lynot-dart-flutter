import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lyform/lyform.dart';

part 'ly_form_events.dart';
part 'ly_form_states.dart';

abstract class LyForm<D, E> extends Bloc<LyFormEvent, LyFormState<D, E>> {
  LyForm() : super(const LyFormPureState()) {
    on<LyFormStartedEvent>((event, emit) async {
      await onStartedEvent(emit);
    });

    on<LyFormChangedEvent>((event, emit) async {
      await onChangedEvent(emit);
    });

    on<LyFormResetEvent>((event, emit) async {
      await onResetEvent(emit);
    });

    on<LyFormSubmitEvent>((event, emit) async {
      await onSubmitEvent(emit);
    });

    add(const LyFormStartedEvent());
  }

  @override
  void onTransition(Transition<LyFormEvent, LyFormState<D, E>> transition) {
    super.onTransition(transition);
    final state = transition.nextState;
    if (state is LyFormPureState<D, E>) {
      onPureState(state);
    } else if (state is LyFormInvalidState<D, E>) {
      onInvalidState(state);
    } else if (state is LyFormValidState<D, E>) {
      onValidState(state);
    } else if (state is LyFormLoadingState<D, E>) {
      onLoadingState(state);
    } else if (state is LyFormSuccessState<D, E>) {
      onSuccessState(state);
    } else if (state is LyFormErrorState<D, E>) {
      onErrorState(state);
    }
  }

  List<LyInput> get inputs;
  Stream<LyFormState<D, E>> onSubmit();
  final _subscriptions = <StreamSubscription<LyInputState<dynamic>>>[];

  /// Called when the form is started.
  Future<void> onStartedEvent(Emitter<LyFormState<D, E>> emit) async {
    for (final input in inputs) {
      _subscriptions.add(
        input.stream.listen((input) => change(input.debugName)),
      );
    }
  }

  /// Called when the form is changed.
  Future<void> onChangedEvent(Emitter<LyFormState<D, E>> emit) async {
    if (isPure()) {
      emit(LyFormPureState<D, E>());
    } else if (isValid()) {
      emit(LyFormValidState<D, E>());
    } else {
      emit(LyFormInvalidState<D, E>());
    }
  }

  /// Called when the form is reset.
  Future<void> onResetEvent(Emitter<LyFormState<D, E>> emit) async {
    for (final input in inputs) {
      input.pure(input.pureValue);
    }
  }

  /// Called when the form is submitted.
  Future<void> onSubmitEvent(Emitter<LyFormState<D, E>> emit) async {
    validate();
    if (!isValid()) {
      emit(LyFormInvalidState<D, E>());
    } else {
      emit(LyFormLoadingState<D, E>());
      await for (final state in onSubmit()) {
        emit(state);
      }
    }
  }

  /// Called when the form transitions to the [LyFormPureState].
  void onPureState(LyFormPureState<D, E> state) {}

  /// Called when the form transitions to the [LyFormValidState].
  void onValidState(LyFormValidState<D, E> state) {}

  /// Called when the form transitions to the [LyFormInvalidState].
  void onInvalidState(LyFormInvalidState<D, E> state) {}

  /// Called when the form transitions to the [LyFormLoadingState].
  void onLoadingState(LyFormLoadingState<D, E> state) {}

  /// Called when the form transitions to the [LyFormSuccessState].
  void onSuccessState(LyFormSuccessState<D, E> state) {
    _setPureInputs();
  }

  /// Called when the form transitions to the [LyFormErrorState].
  void onErrorState(LyFormErrorState<D, E> state) {}

  /// Are every input Valid?
  bool isValid() {
    return inputs.every((input) => input.isValid);
  }

  /// Are every input Pure?
  bool isPure() {
    return inputs.every((input) => input.isPure);
  }

  /// Validate all inputs and return [true] if they all are valids.
  void validate() {
    for (final input in inputs) {
      input.validate();
    }
  }

  /// Use this if you whant to set all input as pure using they current value.
  /// Useful when a success submit happens.
  void _setPureInputs() {
    for (final input in inputs) {
      input.pure(input.value);
    }
  }

  void change(String? debugName) {
    add(LyFormChangedEvent(debugName));
  }

  /// Submit form
  void submit() {
    add(const LyFormSubmitEvent());
  }

  /// Reset form
  void reset() {
    add(const LyFormResetEvent());
  }

  @override
  Future<void> close() async {
    await Future.wait<void>(_subscriptions.map((s) => s.cancel()));
    return super.close();
  }
}
