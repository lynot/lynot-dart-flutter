import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lyform/lyform.dart';

part 'form_events.dart';
part 'form_states.dart';

abstract class FormBloc<D, E> extends Bloc<FormBlocEvent, FormBlocState<D, E>> {
  FormBloc() : super(const FormPureState()) {
    for (final input in inputs) {
      _subscriptions
          .add(input.stream.listen((input) => change(input.debugName)));
    }

    on<FormChangedEvent>((event, emit) {
      if (isPure()) {
        emit(FormPureState<D, E>());
      } else {
        emit(isValid() ? FormValidState<D, E>() : FormInvalidState<D, E>());
      }
    });

    on<FormResetEvent>((event, emit) {
      for (final input in inputs) {
        input.pure(input.pureValue);
      }
    });

    on<FormSubmitEvent>((event, emit) async {
      _validateInputs();
      if (!isValid()) {
        emit(FormInvalidState<D, E>());
      } else {
        await for (final state in onSubmit()) {
          emit(state);
        }
      }
    });
  }

  @override
  void onTransition(Transition<FormBlocEvent, FormBlocState<D, E>> transition) {
    super.onTransition(transition);
    if (transition.nextState is FormSuccessState) {
      _setPureInputs();
    }
  }

  List<InputBloc> get inputs;
  Stream<FormBlocState<D, E>> onSubmit();
  final _subscriptions = <StreamSubscription<InputBlocState<dynamic>>>[];

  ///Are every input Valid?
  bool isValid() {
    return inputs.every((input) => input.isValid);
  }

  ///Are every input Pure?
  bool isPure() {
    return inputs.every((input) => input.isPure);
  }

  ///Validate all inputs and return [true] if they all are valids.
  void _validateInputs() {
    for (final input in inputs) {
      input.validate();
    }
  }

  ///Use this if you whant to set all input as pure using they current value. Useful when a success submmit happens.
  void _setPureInputs() {
    for (final input in inputs) {
      input.pure(input.value);
    }
  }

  void change(String? debugName) {
    add(FormChangedEvent(debugName));
  }

  ///Submit form
  void submit() {
    add(const FormSubmitEvent());
  }

  ///Reset form
  void reset() {
    add(const FormResetEvent());
  }

  @override
  Future<void> close() async {
    await Future.wait<void>(_subscriptions.map((s) => s.cancel()));
    return super.close();
  }
}
