// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:lyform/lyform.dart';

class LyStringRequired extends LyValidator<String> {
  const LyStringRequired(super.message);

  @override
  String? call(String value) =>
      (value.isNotEmpty && !value.contains(RegExp(r'[0-9]$'))) ? null : message;

  @override
  String toString() {
    return 'LyStringRequired(message: $message)';
  }
}

class LyIntRequired extends LyValidator<int> {
  const LyIntRequired(super.message);

  @override
  String? call(int value) => value < 18 ? message : null;

  @override
  String toString() {
    return 'LyIntRequired(message: $message)';
  }
}

class TestForm extends LyForm<String, String> {
  TestForm() {
    addInputs([name]);
  }

  final name = LyInput<String>(
    pureValue: '',
    validationType: LyValidationType.always,
    validator: const LyStringRequired('Invalid name.'),
    debugName: 'name',
  );

  @override
  Stream<LyFormState<String, String>> onSubmit() async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield success('Name save success!');
  }
}

class TestPureForm extends LyForm<String, String> {
  TestPureForm() {
    addInputs([name]);
  }

  final name = LyInput<String>(
    pureValue: 'unknow',
    validationType: LyValidationType.always,
    validator: const LyStringRequired('Invalid name.'),
    debugName: 'name',
  );

  @override
  Stream<LyFormState<String, String>> onSubmit() async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield success('Name save success!');
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent: ${bloc.runtimeType}, event: $event');
  }
}
