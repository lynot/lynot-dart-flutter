import 'package:bloc_test/bloc_test.dart';
import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

import '../../mocks/mock_forms.dart';

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
    'check that isValid is true when isPure is true',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    wait: const Duration(seconds: 1),
    verify: (input) {
      expect(input.isValid, isTrue);
    },
  );

  blocTest<LyInput<String>, LyInputState<String>>(
    'check that isInvalid is true',
    build: () => LyInput<String>(
      pureValue: '',
      validationType: LyValidationType.always,
      validator: const LyStringRequired('Is required.'),
    ),
    wait: const Duration(seconds: 1),
    act: (bloc) => bloc.dirty(''),
    verify: (input) {
      expect(input.isInvalid, isTrue);
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
    act: (input) => input..pure('ly'),
    wait: const Duration(seconds: 1),
    verify: (input) {
      expect(input.pureValue, equals('ly'));
    },
  );
}
