// ignore_for_file: prefer_const_constructors

import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

void main() {
  final input1 = LyInputState<String>(
    value: 'input1',
    lastNotNullValue: 'input1',
    pureValue: 'input1',
  );
  final input2 = LyInputState<String>(
    value: 'input2',
    lastNotNullValue: 'input2',
    pureValue: 'input2',
  );

  group('LyFormPureState', () {
    final lyFormPureState1 = LyFormPureState<Object, Object>(
      [input1, input2],
    );
    final lyFormPureState2 = LyFormPureState<Object, Object>(
      [input1, input2],
    );

    test('supports value equality', () {
      expect(lyFormPureState1, equals(lyFormPureState2));
    });

    test(
      'toString',
      () {
        expect(
          lyFormPureState1.toString(),
          equals(lyFormPureState2.toString()),
        );
      },
    );
  });

  group('LyFormInvalidState', () {
    final lyFormInvalidState1 = LyFormInvalidState<Object, Object>(
      [input1, input2],
    );
    final lyFormInvalidState = LyFormInvalidState<Object, Object>(
      [input1, input2],
    );
    test(
      'supports value equality',
      () {
        expect(lyFormInvalidState1, equals(lyFormInvalidState));
      },
    );

    test(
      'toString',
      () {
        expect(
          lyFormInvalidState1.toString(),
          equals(lyFormInvalidState.toString()),
        );
      },
    );
  });

  group('LyFormValidState', () {
    final lyFormValidState1 = LyFormValidState<Object, Object>(
      [input1, input2],
    );
    final lyFormValidState2 = LyFormValidState<Object, Object>(
      [input1, input2],
    );
    test(
      'supports value equality',
      () {
        expect(lyFormValidState1, equals(lyFormValidState2));
      },
    );

    test(
      'toString',
      () {
        expect(
          lyFormValidState1.toString(),
          equals(lyFormValidState2.toString()),
        );
      },
    );
  });

  group('LyFormLoadingState', () {
    final lyFormLoadingState1 = LyFormLoadingState<Object, Object>(
      [input1, input2],
    );
    final lyFormLoadingState2 = LyFormLoadingState<Object, Object>(
      [input1, input2],
    );

    test(
      'supports value equality',
      () {
        expect(lyFormLoadingState1, equals(lyFormLoadingState2));
      },
    );

    test(
      'toString',
      () {
        expect(
          lyFormLoadingState1.toString(),
          equals(lyFormLoadingState2.toString()),
        );
      },
    );
  });

  group('LyFormSuccessState', () {
    final lyFormSuccessState1 = LyFormSuccessState<String, Object>(
      'Success',
      [input1, input2],
    );
    final lyFormSuccessState2 = LyFormSuccessState<String, Object>(
      'Success',
      [input1, input2],
    );
    test(
      'supports value equality',
      () {
        expect(lyFormSuccessState1, equals(lyFormSuccessState2));
      },
    );

    test(
      'toString',
      () {
        expect(
          lyFormSuccessState1.toString(),
          equals(lyFormSuccessState2.toString()),
        );
      },
    );
  });

  group('LyFormErrorState', () {
    final lyFormErrorState1 =
        LyFormErrorState<Object, String>('Error', const []);
    final lyFormErrorState2 =
        LyFormErrorState<Object, String>('Error', const []);
    test(
      'supports value equality',
      () {
        expect(lyFormErrorState1, equals(lyFormErrorState2));
      },
    );

    test(
      'when `inputs` is not empty',
      () {
        expect(lyFormErrorState1, equals(lyFormErrorState2));
      },
    );

    test(
      'toString',
      () {
        expect(
          lyFormErrorState1.toString(),
          equals(lyFormErrorState2.toString()),
        );
      },
    );
  });
}
