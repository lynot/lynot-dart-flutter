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
    test('supports value equality', () {
      expect(
        LyFormPureState<Object, Object>(
          [input1, input2],
        ),
        equals(
          LyFormPureState<Object, Object>(
            [input1, input2],
          ),
        ),
      );
    });
  });

  group('LyFormInvalidState', () {
    test(
      'supports value equality',
      () {
        expect(
          LyFormInvalidState<Object, Object>(
            [input1, input2],
          ),
          equals(
            LyFormInvalidState<Object, Object>(
              [input1, input2],
            ),
          ),
        );
      },
    );
  });

  group('LyFormValidState', () {
    test(
      'supports value equality',
      () {
        expect(
          LyFormValidState<Object, Object>(
            [input1, input2],
          ),
          equals(
            LyFormValidState<Object, Object>(
              [input1, input2],
            ),
          ),
        );
      },
    );
  });

  group('LyFormLoadingState', () {
    test(
      'supports value equality',
      () {
        expect(
          LyFormLoadingState<Object, Object>(
            [input1, input2],
          ),
          equals(
            LyFormLoadingState<Object, Object>(
              [input1, input2],
            ),
          ),
        );
      },
    );
  });

  group('LyFormSuccessState', () {
    test(
      'supports value equality',
      () {
        expect(
          LyFormSuccessState<String, Object>(
            'Success',
            [input1, input2],
          ),
          equals(
            LyFormSuccessState<String, Object>(
              'Success',
              [input1, input2],
            ),
          ),
        );
      },
    );
  });

  group('LyFormErrorState', () {
    test(
      'supports value equality',
      () {
        expect(
          LyFormErrorState<Object, String>('Error', const []),
          equals(LyFormErrorState<Object, String>('Error', const [])),
        );
      },
    );

    test(
      'when `inputs` is not empty',
      () {
        expect(
          LyFormErrorState<Object, String>(
            'Error',
            [input1, input2],
          ),
          equals(
            LyFormErrorState<Object, String>(
              'Error',
              [input1, input2],
            ),
          ),
        );
      },
    );
  });
}
