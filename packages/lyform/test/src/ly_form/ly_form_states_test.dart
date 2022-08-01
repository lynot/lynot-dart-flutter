// ignore_for_file: prefer_const_constructors

import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

void main() {
  group('LyFormPureState', () {
    group('supports value equality in', () {
      test('LyFormPureState', () {
        expect(
          LyFormPureState<Object, Object>([]),
          LyFormPureState<Object, Object>([]),
        );
      });

      test(
        'LyFormInvalidState',
        () {
          expect(
            LyFormInvalidState<Object, Object>([]),
            equals(LyFormInvalidState<Object, Object>([])),
          );
        },
      );

      test(
        'LyFormValidState',
        () {
          expect(
            LyFormValidState<Object, Object>([]),
            equals(LyFormValidState<Object, Object>([])),
          );
        },
      );

      test(
        'LyFormLoadingState',
        () {
          expect(
            LyFormLoadingState<Object, Object>([]),
            equals(LyFormLoadingState<Object, Object>([])),
          );
        },
      );

      test(
        'LyFormSuccessState',
        () {
          expect(
            LyFormSuccessState<String, Object>('Success', []),
            equals(LyFormSuccessState<String, Object>('Success', [])),
          );
        },
      );

      test(
        'LyFormErrorState',
        () {
          expect(
            LyFormErrorState<Object, String>('Error', []),
            equals(LyFormErrorState<Object, String>('Error', [])),
          );
        },
      );
    });
  });
}
