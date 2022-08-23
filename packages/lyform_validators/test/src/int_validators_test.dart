import 'package:lyform_validators/lyform_validators.dart';
import 'package:test/test.dart';

void main() {
  group('IntValidators', () {
    group('LyIntGreaterThan', () {
      test('should return `null` when value is greater than limit', () {
        final validation = LyIntGreaterThan(11, 'Must be greater than 11');
        final result = validation(15);
        expect(result, isNull);
      });

      test('should return a meesage when the value is not greater than limit',
          () {
        final validation = LyIntGreaterThan(11, 'Must be greater than 11');
        final result = validation(10);
        expect(result, 'Must be greater than 11');
      });
    });

    group('LyIntGreaterEqualThan', () {
      test('should return `null` when value is greater than limit', () {
        final validation = LyIntGreaterEqualThan(12, 'Must be greater than 12');
        final result = validation(14);
        expect(result, isNull);
      });

      test('should return `null` when value is equals than limit', () {
        final validation = LyIntGreaterEqualThan(16, 'Must be greater than 16');
        final result = validation(16);
        expect(result, isNull);
      });

      test('should return a meesage when the value is not greater than limit',
          () {
        final validation =
            LyIntGreaterEqualThan(8, 'Must be greater or equals than 8');
        final result = validation(6);
        expect(result, 'Must be greater or equals than 8');
      });
    });

    group('LyIntLesserThan', () {
      test('should return `null` when value is lesser than limit', () {
        final validation = LyIntLesserThan(12, 'Must be lesser than 12');
        final result = validation(10);
        expect(result, isNull);
      });

      test('should return a meesage when the value is not lesser than limit',
          () {
        final validation = LyIntLesserThan(21, 'Must be lesser than 21');
        final result = validation(31);
        expect(result, 'Must be lesser than 21');
      });
    });

    group('LyIntLesserEquealThan', () {
      test('should return `null` when value is lesser than limit', () {
        final validation = LyIntLesserEquealThan(12, 'Must be lesser than 12');
        final result = validation(10);
        expect(result, isNull);
      });

      test('should return `null` when value is equal than limit', () {
        final validation = LyIntLesserEquealThan(16, 'Must be equal than 16');
        final result = validation(16);
        expect(result, isNull);
      });

      test('should return a meesage when the value is not lesser than limit',
          () {
        final validation = LyIntLesserEquealThan(21, 'Must be lesser than 21');
        final result = validation(31);
        expect(result, 'Must be lesser than 21');
      });
    });

    group('LyIntNonNegative', () {
      test('should return `null` when value is not negative', () {
        final validation = LyIntNonNegative('Must be non negative');
        final result = validation(1);
        expect(result, isNull);
      });

      test('should return a meesage when the value is negative', () {
        final validation = LyIntNonNegative('Must be non negative');
        final result = validation(-1);
        expect(result, 'Must be non negative');
      });
    });
  });
}
