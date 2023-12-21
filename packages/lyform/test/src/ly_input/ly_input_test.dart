import 'package:bloc_test/bloc_test.dart';
import 'package:lyform/lyform.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mock_forms.dart';

class MockLyInputBloc<T> extends MockBloc<LyInputEvent<T>, LyInputState<T>>
    implements LyInput<T> {}

void main() {
  blocTest<LyInput<String>, LyInputState<String>>(
    'check that emit new state in every `drity` call',
    build: () => LyInput<String>(pureValue: ''),
    act: (input) => input
      ..dirty('ly')
      ..dirty('')
      ..dirty('lyf'),
    wait: const Duration(seconds: 1),
    expect: () => [
      const LyInputState(
        value: 'ly',
        lastNotNullValue: 'ly',
        pureValue: '',
      ),
      const LyInputState(
        value: '',
        lastNotNullValue: '',
        pureValue: '',
      ),
      const LyInputState(
        value: 'lyf',
        lastNotNullValue: 'lyf',
        pureValue: '',
      ),
    ],
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that isPure is true',
    build: () => LyInput<String>(
      pureValue: '',
    ),
    act: (input) => input
      ..dirty('ly')
      ..dirty(''),
    wait: const Duration(seconds: 1),
    verify: (input) {
      expect(input.isPure, isTrue);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that isPure is false',
    build: () => LyInput<String>(
      pureValue: '',
    ),
    act: (input) => input..dirty('ly'),
    wait: const Duration(seconds: 1),
    verify: (input) {
      expect(input.isPure, isFalse);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that isValid is "false" when validate the invalid pure value',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    wait: const Duration(seconds: 1),
    verify: (input) {
      expect(input.isPure, isTrue);
      expect(input.isValid, isFalse);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that isValid is "true" when validate the valid pure value',
    build: () => LyInput<String>(
      pureValue: 'hello',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    wait: const Duration(seconds: 1),
    verify: (input) {
      expect(input.isPure, isTrue);
      expect(input.isValid, isTrue);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that isInvalid is "true" when validate the invalid pure value',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    wait: const Duration(seconds: 1),
    verify: (input) {
      expect(input.isPure, isTrue);
      expect(input.isInvalid, isTrue);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that isInvalid is "false" when validate the valid pure value',
    build: () => LyInput<String>(
      pureValue: 'hello',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    wait: const Duration(seconds: 1),
    verify: (input) {
      expect(input.isPure, isTrue);
      expect(input.isInvalid, isFalse);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that get the correct state value and lastNotNullValue',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    wait: const Duration(seconds: 1),
    act: (bloc) => bloc.dirty('ly'),
    verify: (input) {
      expect(input.lastNotNullValue, equals('ly'));
      expect(input.value, equals('ly'));
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that get the correct validator',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    wait: const Duration(seconds: 1),
    act: (bloc) => bloc.dirty('ly'),
    verify: (input) {
      expect(input.validator, equals(const LyStringRequired('Is required.')));
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check pure event',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    act: (input) => input.pure('ly'),
    expect: () => [
      const LyInputState(
        value: 'ly',
        lastNotNullValue: 'ly',
        pureValue: 'ly',
      ),
    ],
    verify: (input) {
      expect(input.pureValue, equals('ly'));
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check state when validationType is `none`',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.none,
      validator: const LyStringRequired('Is required.'),
    ),
    verify: (input) {
      expect(input.pureValue, equals(''));
      expect(input.isValid, isTrue);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check state when validationType is `none` and call drity',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.none,
      validator: const LyStringRequired('Is required.'),
    ),
    act: (input) => input.dirty('ly'),
    expect: () => [
      const LyInputState(
        value: 'ly',
        lastNotNullValue: 'ly',
        pureValue: '',
      ),
    ],
    verify: (input) {
      expect(input.value, equals('ly'));
      expect(input.isValid, isTrue);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check state when validationType is `explicit`',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.explicit,
      validator: const LyStringRequired('Is required.'),
    ),
    verify: (input) {
      expect(input.pureValue, equals(''));
      expect(input.isValid, isTrue);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check state when validationType is `explicit` and call dirty',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.explicit,
      validator: const LyStringRequired('Is required.'),
    ),
    act: (input) => input.dirty('ly'),
    expect: () => [
      const LyInputState(
        value: 'ly',
        lastNotNullValue: 'ly',
        pureValue: '',
      ),
    ],
    verify: (input) {
      expect(input.value, equals('ly'));
      expect(input.isValid, isTrue);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check state when validationType is `always`',
    build: () => MockLyInputBloc<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    verify: (input) {
      expect(input.pureValue, equals(''));
      expect(input.value, equals(''));
      expect(input.isValid, isFalse);

      verify(() => input.validate()).called(1);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check state when validationType is `always` and call dirty',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    act: (input) => input.dirty('ly'),
    expect: () => [
      const LyInputState(
        value: 'ly',
        lastNotNullValue: 'ly',
        pureValue: '',
      ),
    ],
    verify: (input) {
      expect(input.value, equals('ly'));
      expect(input.isValid, isTrue);
    },
  );
}
