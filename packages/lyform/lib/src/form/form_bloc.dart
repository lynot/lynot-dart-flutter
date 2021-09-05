import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lyform/lyform.dart';

part 'form_events.dart';
part 'form_states.dart';

abstract class FormBloc<D, E> extends Bloc<FormBlocEvent, FormBlocState<D, E>> {
  FormBloc() : super(const FormPureState()) {
    for (final input in inputs) {
      input.stream.listen((_) => change());
    }
    on<FormChangedEvent>((event, emit) {
      if (isPure()) {
        emit(FormPureState<D, E>());
      } else {
        emit(isValid() ? FormValidState<D, E>() : FormInvalidState<D, E>());
      }
    });
    on<FormSubmitEvent>((event, emit) async {
      if (!validate()) {
        emit(FormInvalidState<D, E>());
        return;
      } else {
        emit(FormLoadingState<D, E>());
        emit(await onSubmmit());
      }
    });
  }

  List<InputBloc> get inputs;
  Future<FormBlocState<D, E>> onSubmmit();

  bool isValid() {
    return inputs.every((input) => input.isValid);
  }

  bool isPure() {
    return inputs.every((input) => input.isPure);
  }

  bool validate() {
    for (final input in inputs) {
      input.validate();
    }
    return isValid();
  }

  void change() {
    add(const FormChangedEvent());
  }

  void submit() {
    add(const FormSubmitEvent());
  }
}
