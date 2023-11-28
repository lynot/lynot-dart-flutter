// ignore_for_file: prefer_const_constructors

import 'package:lyform/src/ly_input/ly_input.dart';
import 'package:test/test.dart';

import '../../mocks/mock_forms.dart';

void main() {
  const emptyValue = '';
  const value = 'value';
  const message = 'Can not be a empty string';
  final lyStringRequired = LyStringRequired(message);

  group('LyAndValidator', () {
    test(
        'should call the `left` side first and return a message when is invalid.',
        () {
      final andValidator = LyAndValidator<String>(
        lyStringRequired,
        LyEmptyValidator<String>(),
      );

      expect(lyStringRequired(emptyValue), equals(message));
      expect(andValidator(emptyValue), equals(message));
    });

    test('should call the `left` side first and return null when is valid.',
        () {
      final andValidator = LyAndValidator<String>(
        lyStringRequired,
        LyEmptyValidator<String>(),
      );

      expect(lyStringRequired(value), isNull);
      expect(andValidator(value), isNull);
    });

    test(
        'should call the `right` side when the result '
        'of the `left` side is null. Return null when is valid', () {
      final andValidator = LyAndValidator<String>(
        lyStringRequired,
        LyEmptyValidator<String>(),
      );

      expect(lyStringRequired(value), isNull);
      expect(andValidator(value), isNull);
    });

    test(
        'should call the `right` side when the result of the `left` side is '
        'null. Return a message when is invalid.', () {
      final andValidator = LyAndValidator<String>(
        lyStringRequired,
        LyEmptyValidator<String>(),
      );

      expect(lyStringRequired(emptyValue), equals(message));
      expect(andValidator(emptyValue), equals(message));
    });
  });

  group('LyOrValidator', () {
    test(
        'should call left and right side. Return a message when both sides '
        'are invalid', () {
      final lyOrValidator = LyOrValidator<String>(
        lyStringRequired,
        lyStringRequired,
      );

      expect(lyStringRequired(emptyValue), equals(message));
      expect(lyOrValidator(emptyValue), equals(message));
    });

    test(
        'should call left and right side. Return null when both sides '
        'are valid', () {
      final lyOrValidator = LyOrValidator<String>(
        lyStringRequired,
        lyStringRequired,
      );

      expect(lyStringRequired(value), isNull);
      expect(lyOrValidator(value), isNull);
    });
  });

  group('LyListValidator', () {
    test('return null when one or more validators are valid', () {
      final lyListValidator = LyListValidator<String>([
        lyStringRequired.call,
        lyStringRequired.call,
      ]);

      expect(lyStringRequired(value), isNull);
      expect(lyListValidator(value), isNull);
    });

    test('return null when the list is empty', () {
      final lyListValidator = LyListValidator<String>([]);

      expect(lyStringRequired(value), isNull);
      expect(lyListValidator(value), isNull);
    });

    test('return a message when one or more validators are invalid', () {
      final lyListValidator = LyListValidator<String>([
        lyStringRequired.call,
        LyEmptyValidator<String>().call,
        LyEmptyValidator<String>().call,
      ]);

      expect(lyStringRequired(emptyValue), equals(message));
      expect(lyListValidator(emptyValue), equals(message));
    });
  });

  group('LyBaseValidator', () {
    test('return `LyAndValidator` when applay the `&` operator', () {
      final result = LyEmptyValidator<String>() & lyStringRequired;

      expect(result, isA<LyAndValidator>());
      expect(result, isNot(LyOrValidator));
    });

    test('return `LyOrValidator` when applay the `|` operator', () {
      final result = LyEmptyValidator<String>() | lyStringRequired;

      expect(result, isA<LyOrValidator>());
      expect(result, isNot(LyAndValidator));
    });
  });
}
