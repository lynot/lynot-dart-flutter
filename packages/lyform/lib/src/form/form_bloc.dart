import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lyform/lyform.dart';

part 'form_states.dart';
part 'form_events.dart';

abstract class FormBloc<D, E> extends Bloc<FormBlocEvent, FormBlocState<D, E>> {
  FormBloc() : super(FormPureState()) {
    for (var input in inputs)
      input.stream.listen(
        (event) => change(),
      );
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
    for (var input in inputs) input.validate();
    return isValid();
  }

  void change() {
    add(const FormChangedEvent());
  }

  void submit() {
    add(const FormSubmitEvent());
  }

  @override
  Stream<FormBlocState<D, E>> mapEventToState(FormBlocEvent event) async* {
    if (event is FormChangedEvent) {
      if (isPure())
        yield FormPureState<D, E>();
      else
        yield isValid() ? FormValidState<D, E>() : FormInvalidState<D, E>();
    }
    if (event is FormSubmitEvent) {
      if (!validate()) {
        yield FormInvalidState<D, E>();
        return;
      } else {
        yield FormLoadingState<D, E>();
        yield await onSubmmit();
      }
    }
  }
}
