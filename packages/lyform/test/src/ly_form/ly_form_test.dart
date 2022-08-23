import 'package:bloc_test/bloc_test.dart';
import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

import '../../mocks/mock_forms.dart';

void main() {
  final lyInputAge = LyInput<int>(
    pureValue: 18,
    validationType: LyValidationType.always,
    validator: const LyIntRequired('The minimum age is 18.'),
    debugName: 'age',
  );

  group('LyForm', () {
    blocTest<TestForm, LyFormState>(
      'check that emit new state in every `drity` call',
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

    blocTest<TestForm, LyFormState>(
      'check that add one input in the index 1',
      build: () => TestForm(),
      act: (form) => form.addInput(1, lyInputAge),
      skip: 1,
      expect: () => [
        const LyFormPureState<String, String>([
          LyInputState(
            value: '',
            lastNotNullValue: '',
            pureValue: '',
            debugName: 'name',
          ),
          LyInputState<int>(
            value: 18,
            lastNotNullValue: 18,
            pureValue: 18,
            debugName: 'age',
          ),
        ]),
      ],
    );

    blocTest<TestForm, LyFormState>(
      'check that input in the index 1 was removed',
      build: () => TestForm(),
      act: (form) => form
        ..addInput(1, lyInputAge)
        ..removeInput(1),
      skip: 2,
      expect: () => const [
        LyFormPureState<String, String>([
          LyInputState(
            value: '',
            lastNotNullValue: '',
            pureValue: '',
            debugName: 'name',
          ),
        ])
      ],
    );

    blocTest<TestForm, LyFormState>(
      'check that all the input was reset',
      build: () {
        // Bloc.observer = MyBlocObserver();
        return TestForm();
      },
      act: (form) => form
        ..name.dirty('ly')
        ..reset(),
      skip: 1,
      wait: const Duration(seconds: 1),
      expect: () => const [
        LyFormValidState<String, String>([
          LyInputState(
            value: 'ly',
            lastNotNullValue: 'ly',
            pureValue: '',
            debugName: 'name',
          ),
        ]),
        LyFormPureState<String, String>([
          LyInputState(
            value: '',
            lastNotNullValue: '',
            pureValue: '',
            debugName: 'name',
          ),
        ])
      ],
    );
  });
}
