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
      'check that form is "pure" and "invalid" without make any cahnge in the inputs',
      build: () => TestForm(),
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
      ],
      verify: (form) {
        expect(form.isPure(), isTrue);
        expect(form.isInvalid(), isTrue);
      },
    );

    blocTest<TestPureForm, LyFormState>(
      'check that form is "pure" and "valid" without make any cahnge in the inputs',
      build: () => TestPureForm(),
      wait: const Duration(seconds: 1),
      expect: () => [
        const LyFormPureState<String, String>([
          LyInputState(
            value: 'unknow',
            lastNotNullValue: 'unknow',
            pureValue: 'unknow',
            debugName: 'name',
          ),
          LyInputState(
            value: 'unknow',
            lastNotNullValue: 'unknow',
            pureValue: 'unknow',
            debugName: 'lastname',
          ),
        ]),
      ],
      verify: (form) {
        expect(form.isPure(), isTrue);
        expect(form.isValid(), isTrue);
      },
    );

    blocTest<TestForm, LyFormState>(
      'check that form is a "pure and invalid form" when make invalid change a input',
      build: () => TestForm(),
      act: (form) {
        form.name.dirty('007');
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
        const LyFormInvalidState<String, String>([
          LyInputState(
            value: '007',
            lastNotNullValue: '007',
            pureValue: '',
            debugName: 'name',
            error: 'Invalid name.',
          ),
        ]),
      ],
      verify: (form) {
        expect(form.isPure(), isFalse);
        expect(form.isValid(), isFalse);
      },
    );

    blocTest<TestPureForm, LyFormState>(
      'check that form is a "pure and valid form" when make valid change a input',
      build: () => TestPureForm(),
      act: (form) {
        form.name.dirty('Laura');
      },
      wait: const Duration(seconds: 1),
      expect: () => [
        const LyFormPureState<String, String>([
          LyInputState(
            value: 'unknow',
            lastNotNullValue: 'unknow',
            pureValue: 'unknow',
            debugName: 'name',
          ),
          LyInputState(
            value: 'unknow',
            lastNotNullValue: 'unknow',
            pureValue: 'unknow',
            debugName: 'lastname',
          ),
        ]),
        const LyFormValidState<String, String>([
          LyInputState(
            value: 'Laura',
            lastNotNullValue: 'Laura',
            pureValue: 'unknow',
            debugName: 'name',
          ),
          LyInputState(
            value: 'unknow',
            lastNotNullValue: 'unknow',
            pureValue: 'unknow',
            debugName: 'lastname',
          ),
        ]),
      ],
      verify: (form) {
        expect(form.isPure(), isFalse);
        expect(form.isValid(), isTrue);
      },
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
      verify: (form) {
        expect(form.isPure(), isTrue);
        expect(form.isValid(), isFalse);
      },
    );

    blocTest<TestForm, LyFormState>(
      'check that throw an exception when is added one input in out of range',
      build: () => TestForm(),
      act: (form) => form.addInput(5, lyInputAge),
      skip: 1,
      errors: () => [
        isA<Exception>().having(
          (e) => e.toString(),
          'Exception message error',
          'Exception: Index out of range.',
        ),
      ],
    );

    blocTest<TestForm, LyFormState>(
      'check that all inputs with values as int was removed',
      build: () => TestForm(),
      act: (form) async {
        form
          ..addInput(1, lyInputAge)
          ..addInput(2, lyInputAge);

        await Future.delayed(
          const Duration(milliseconds: 50),
          () => form.removeInputsWhen((input) => input.value is int),
        );

        return form;
      },
      skip: 2,
      expect: () => const [
        LyFormPureState<String, String>([
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
          LyInputState<int>(
            value: 18,
            lastNotNullValue: 18,
            pureValue: 18,
            debugName: 'age',
          ),
        ]),
        LyFormPureState<String, String>([
          LyInputState(
            value: '',
            lastNotNullValue: '',
            pureValue: '',
            debugName: 'name',
          ),
        ]),
      ],
      verify: (bloc) => expect(bloc.length, equals(1)),
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
        ]),
      ],
    );

    blocTest<TestForm, LyFormState>(
      'check that throw an exception when is removed an input is out of range',
      build: () => TestForm(),
      act: (form) => form
        ..addInput(1, lyInputAge)
        ..removeInput(4),
      skip: 2,
      errors: () => [
        isA<Exception>().having(
          (e) => e.toString(),
          'Exception message error',
          'Exception: Index out of range.',
        ),
      ],
    );

    blocTest<TestForm, LyFormState>(
      'check that all the input was reset',
      build: () => TestForm(),
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
        ]),
      ],
    );

    blocTest<TestForm, LyFormState>(
      'check when submit was called and state is valid',
      build: () => TestForm(),
      act: (form) => form
        ..name.dirty('ly')
        ..submit(),
      skip: 1,
      wait: const Duration(seconds: 2),
      expect: () => const [
        LyFormValidState<String, String>([
          LyInputState(
            value: 'ly',
            lastNotNullValue: 'ly',
            pureValue: '',
            debugName: 'name',
          ),
        ]),
        LyFormLoadingState<String, String>([
          LyInputState<String>(
            value: 'ly',
            lastNotNullValue: 'ly',
            pureValue: '',
            debugName: 'name',
          ),
        ]),
        LyFormSuccessState<String, String>(
          'Name save success!',
          [
            LyInputState(
              value: 'ly',
              lastNotNullValue: 'ly',
              pureValue: '',
              debugName: 'name',
            ),
          ],
        ),
        LyFormPureState<String, String>([
          LyInputState<String>(
            value: 'ly',
            lastNotNullValue: 'ly',
            pureValue: 'ly',
            debugName: 'name',
          ),
        ]),
      ],
    );

    blocTest<TestForm, LyFormState>(
      'check when submit event was called and is dropped when is more than one',
      build: () => TestForm(),
      act: (form) => form
        ..name.dirty('ly')
        ..submit()
        ..submit()
        ..submit(),
      skip: 1,
      wait: const Duration(seconds: 2),
      expect: () => const [
        LyFormValidState<String, String>([
          LyInputState(
            value: 'ly',
            lastNotNullValue: 'ly',
            pureValue: '',
            debugName: 'name',
          ),
        ]),
        LyFormLoadingState<String, String>([
          LyInputState<String>(
            value: 'ly',
            lastNotNullValue: 'ly',
            pureValue: '',
            debugName: 'name',
          ),
        ]),
        LyFormSuccessState<String, String>(
          'Name save success!',
          [
            LyInputState<String>(
              value: 'ly',
              lastNotNullValue: 'ly',
              pureValue: '',
              debugName: 'name',
            ),
          ],
        ),
        LyFormPureState<String, String>(
          [
            LyInputState<String>(
              value: 'ly',
              lastNotNullValue: 'ly',
              pureValue: 'ly',
              debugName: 'name',
            ),
          ],
        ),
      ],
    );

    blocTest<TestForm, LyFormState>(
      'check inputStates getter',
      build: () => TestForm(),
      verify: (form) => expect(
        form.inputStates,
        isA<List<LyInputState>>().having(
          (i) => i.length,
          'inputs state length',
          equals(1),
        ),
      ),
    );

    blocTest<TestForm, LyFormState>(
      'check iterator operator',
      build: () => TestForm(),
      verify: (form) {
        final result = form[0];
        expect(
          result,
          isA<LyInput>().having(
            (i) => i.debugName,
            'debugName',
            equals('name'),
          ),
        );
      },
    );

    group('check that method', () {
      blocTest<TestForm, LyFormState>(
        'pure returns a new LyFormPureState',
        build: () => TestForm(),
        verify: (form) => expect(
          form.pure(),
          equals(LyFormPureState<String, String>(form.inputStates)),
        ),
      );

      blocTest<TestForm, LyFormState>(
        'valid returns a new LyFormValidState',
        build: () => TestForm(),
        verify: (form) => expect(
          form.valid(),
          equals(LyFormValidState<String, String>(form.inputStates)),
        ),
      );

      blocTest<TestForm, LyFormState>(
        'invalid returns a new LyFormInvalidState',
        build: () => TestForm(),
        verify: (form) => expect(
          form.invalid(),
          equals(LyFormInvalidState<String, String>(form.inputStates)),
        ),
      );

      blocTest<TestForm, LyFormState>(
        'loading returns a new LyFormLoadingState',
        build: () => TestForm(),
        verify: (form) => expect(
          form.loading(),
          equals(LyFormLoadingState<String, String>(form.inputStates)),
        ),
      );

      blocTest<TestForm, LyFormState>(
        'success returns a new LyFormSuccessState',
        build: () => TestForm(),
        verify: (form) => expect(
          form.success('Name save success!'),
          equals(
            LyFormSuccessState<String, String>(
              'Name save success!',
              form.inputStates,
            ),
          ),
        ),
      );

      blocTest<TestForm, LyFormState>(
        'error returns a new LyFormErrorState',
        build: () => TestForm(),
        verify: (form) => expect(
          form.error('Name save error!'),
          equals(
            LyFormErrorState<String, String>(
              'Name save error!',
              form.inputStates,
            ),
          ),
        ),
      );
    });

    group('check iterable method', () {
      blocTest<TestForm, LyFormState>(
        'any',
        build: () => TestForm(),
        verify: (form) {
          final result = form.any((input) => input.debugName == 'name');
          expect(result, isTrue);
        },
      );

      blocTest<TestForm, LyFormState>(
        'cast',
        build: () => TestForm(),
        verify: (form) {
          final result = form.cast<LyInput<int>>();
          expect(result, isA<Iterable<LyInput<int>>>());
        },
      );

      blocTest<TestForm, LyFormState>(
        'contains',
        build: () => TestForm(),
        verify: (form) {
          final result = form.contains(lyInputAge);
          expect(result, isFalse);
        },
      );

      blocTest<TestForm, LyFormState>(
        'elementAt',
        build: () => TestForm(),
        verify: (form) {
          final result = form.elementAt(0);
          expect(
            result,
            isA<LyInput>().having(
              (i) => i.debugName,
              'debugName',
              equals('name'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'every',
        build: () => TestForm(),
        verify: (form) {
          final result = form.every((input) => input.debugName == 'name');
          expect(result, isTrue);
        },
      );

      blocTest<TestForm, LyFormState>(
        'expand',
        build: () => TestForm(),
        verify: (form) {
          final result =
              form.expand<String?>((input) => [input.debugName]).toList();

          expect(result, isA<List<String?>>());
          expect(result, equals(['name']));
        },
      );

      blocTest<TestForm, LyFormState>(
        'first',
        build: () => TestForm(),
        verify: (form) {
          final result = form.first;
          expect(
            result,
            isA<LyInput>().having(
              (i) => i.debugName,
              'debugName',
              equals('name'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'firstWhere',
        build: () => TestForm(),
        verify: (form) {
          final result = form.firstWhere((input) => input.debugName == 'name');
          expect(
            result,
            isA<LyInput>().having(
              (i) => i.debugName,
              'debugName',
              equals('name'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'fold',
        build: () => TestForm(),
        verify: (form) {
          final result = form.fold<String>(
            '',
            (value, input) => '$value${input.debugName},',
          );

          expect(result, equals('name,'));
        },
      );

      blocTest<TestForm, LyFormState>(
        'forEach',
        build: () => TestForm(),
        verify: (form) {
          // ignore: avoid_function_literals_in_foreach_calls
          form.forEach((input) => expect(input.debugName, 'name'));
        },
      );

      blocTest<TestForm, LyFormState>(
        'followedBy',
        build: () => TestForm(),
        verify: (form) {
          final result = form.followedBy([lyInputAge]);
          expect(
            result,
            isA<Iterable<LyInput>>().having(
              (i) => i,
              'inputs',
              isA<Iterable<LyInput>>()
                  .having(
                    (i) => i.length,
                    'items length',
                    equals(2),
                  )
                  .having(
                    (i) => i.last.debugName,
                    'debugName',
                    'age',
                  ),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'isEmpty',
        build: () => TestForm(),
        verify: (form) {
          final result = form.isEmpty;
          expect(result, isFalse);
        },
      );

      blocTest<TestForm, LyFormState>(
        'isNotEmpty',
        build: () => TestForm(),
        verify: (form) {
          final result = form.isNotEmpty;
          expect(result, isTrue);
        },
      );

      blocTest<TestForm, LyFormState>(
        'iterator',
        build: () => TestForm(),
        verify: (form) {
          final iterator = form.iterator;
          final haveNext = iterator.moveNext();
          expect(haveNext, isTrue);
          expect(
            iterator,
            isA<Iterator<LyInput>>().having(
              (i) => i.current.debugName,
              'debugName',
              equals('name'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'join',
        build: () => TestForm(),
        act: (form) => form.addInput(1, lyInputAge),
        verify: (form) {
          final result = form.join(',');
          expect(
            result,
            equals(
              'LyInput(value: , error: null, validationType: LyValidationType.always, debugName: name),LyInput(value: 18, error: null, validationType: LyValidationType.always, debugName: age)',
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'last',
        build: () => TestForm(),
        verify: (form) {
          final result = form.last;
          expect(
            result,
            isA<LyInput>().having(
              (i) => i.debugName,
              'debugName',
              equals('name'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'lastWhere',
        build: () => TestForm(),
        verify: (form) {
          final result = form.lastWhere((input) => input.debugName == 'name');
          expect(
            result,
            isA<LyInput>().having(
              (i) => i.debugName,
              'debugName',
              equals('name'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'map',
        build: () => TestForm(),
        verify: (form) {
          final result = form.map((input) => input.debugName).toList();
          expect(result, equals(['name']));
        },
      );

      blocTest<TestForm, LyFormState>(
        'reduce',
        build: () => TestForm(),
        act: (form) => form.addInput(1, lyInputAge),
        verify: (form) {
          final result = form.reduce((value, input) => input);
          expect(
            result,
            isA<LyInput>().having(
              (i) => i.debugName,
              'debugName',
              equals('age'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'single',
        build: () => TestForm(),
        verify: (form) {
          final result = form.single;
          expect(
            result,
            isA<LyInput>().having(
              (i) => i.debugName,
              'debugName',
              equals('name'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'singleWhere',
        build: () => TestForm(),
        verify: (form) {
          final result = form.singleWhere((input) => input.debugName == 'name');
          expect(
            result,
            isA<LyInput>().having(
              (i) => i.debugName,
              'debugName',
              equals('name'),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'skip',
        build: () => TestForm(),
        verify: (form) {
          final result = form.skip(1);
          expect(
            result,
            isA<Iterable<LyInput>>().having(
              (i) => i,
              'inputs',
              isA<Iterable<LyInput>>().having(
                (i) => i.length,
                'iterable length',
                equals(0),
              ),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'skipWhile',
        build: () => TestForm(),
        act: (form) => form.addInput(1, lyInputAge),
        verify: (form) {
          final result = form.skipWhile((input) => input.debugName == 'name');
          expect(
            result,
            isA<Iterable<LyInput>>().having(
              (i) => i,
              'inputs',
              isA<Iterable<LyInput>>()
                  .having(
                    (i) => i.length,
                    'iterable length',
                    equals(1),
                  )
                  .having(
                    (i) => i.single.debugName,
                    'debugName',
                    'age',
                  ),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'take',
        build: () => TestForm(),
        verify: (form) {
          final result = form.take(1);
          expect(
            result,
            isA<Iterable<LyInput>>().having(
              (i) => i,
              'inputs',
              isA<Iterable<LyInput>>().having(
                (i) => i.length,
                'iterable length',
                equals(1),
              ),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'takeWhile',
        build: () => TestForm(),
        act: (form) => form.addInput(1, lyInputAge),
        verify: (form) {
          final result = form.takeWhile((input) => input.debugName == 'name');

          expect(form.length, equals(2));
          expect(
            result,
            isA<Iterable<LyInput>>().having(
              (i) => i,
              'inputs',
              isA<Iterable<LyInput>>()
                  .having(
                    (i) => i.length,
                    'iterable length',
                    equals(1),
                  )
                  .having(
                    (i) => i.single.debugName,
                    'debugName',
                    'name',
                  ),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'toList',
        build: () => TestForm(),
        verify: (form) {
          final result = form.toList();
          expect(
            result,
            isA<List<LyInput>>().having(
              (i) => i.length,
              'inputs length',
              equals(1),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'toSet',
        build: () => TestForm(),
        verify: (form) {
          final result = form.toSet();
          expect(
            result,
            isA<Set<LyInput>>().having(
              (i) => i.length,
              'inputs length',
              equals(1),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'where',
        build: () => TestForm(),
        verify: (form) {
          final result = form.where((input) => input.debugName == 'name');
          expect(
            result,
            isA<Iterable<LyInput>>().having(
              (i) => i,
              'inputs',
              isA<Iterable<LyInput>>().having(
                (i) => i.length,
                'iterable length',
                equals(1),
              ),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'whereType',
        build: () => TestForm(),
        verify: (form) {
          final result = form.whereType<LyInput>();
          expect(
            result,
            isA<Iterable<LyInput>>().having(
              (i) => i,
              'inputs',
              isA<Iterable<LyInput>>().having(
                (i) => i.length,
                'iterable length',
                equals(1),
              ),
            ),
          );
        },
      );

      blocTest<TestForm, LyFormState>(
        'length',
        build: () => TestForm(),
        verify: (form) {
          final result = form.length;
          expect(result, equals(1));
        },
      );
    });
  });
}
