import 'package:bloc_test/bloc_test.dart';
import 'package:lyform/lyform.dart';

class LyStringRequired extends LyValidator<String> {
  const LyStringRequired(super.message);
  @override
  String? call(String value) => value.isNotEmpty ? null : message;
}

class TestForm extends LyForm<String, String> {
  TestForm() {
    addInputs([name]);
  }

  final name = LyInput<String>(
    pureValue: '',
    validationType: LyValidationType.always,
    validator: const LyStringRequired('Name is required.'),
    debugName: 'name',
  );

  @override
  Stream<LyFormState<String, String>> onSubmit() async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield success('Name save success!');
  }
}

void main() {
  blocTest<TestForm, LyFormState>(
    'should emit new state in every `drity` call',
    build: () => TestForm(),
    act: (form) {
      form.name.dirty('ly');
      form.name.dirty('asafe');
      form.name.dirty('qwely');
      form.name.dirty('lywefwef');
    },
    wait: const Duration(seconds: 1),
    expect: () => [
      const LyFormPureState<String, String>([
        LyInputState(
          value: '',
          lastNotNullValue: '',
          pureValue: '',
          debugName: 'name',
        ),
      ]),
      const LyFormValidState<String, String>([
        LyInputState(
          value: 'ly',
          lastNotNullValue: 'ly',
          pureValue: '',
          debugName: 'name',
        ),
      ]),
      const LyFormValidState<String, String>([
        LyInputState(
          value: 'asafe',
          lastNotNullValue: 'asafe',
          pureValue: '',
          debugName: 'name',
        ),
      ]),
      const LyFormValidState<String, String>([
        LyInputState(
          value: 'qwely',
          lastNotNullValue: 'qwely',
          pureValue: '',
          debugName: 'name',
        ),
      ]),
      const LyFormValidState<String, String>([
        LyInputState(
          value: 'lywefwef',
          lastNotNullValue: 'lywefwef',
          pureValue: '',
          debugName: 'name',
        ),
      ]),
    ],
  );
}
