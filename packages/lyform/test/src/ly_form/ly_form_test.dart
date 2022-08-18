import 'package:bloc_test/bloc_test.dart';
import 'package:lyform/lyform.dart';

import '../../mocks/mock_forms.dart';

void main() {
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
}
