import 'package:lyform_validators/src/general_validators.dart';
import 'package:test/test.dart';

void main() {
  group('General Validators', () {
    group('Required', () {
      test('should return `null` when the `value` is not null', () {
        final validation = LyRequired<int>('Must be required');
        final result = validation(15);
        expect(result, isNull);
      });

      test('should return a `message` when the `value` is null', () {
        final validation = LyRequired<int?>('Must be required');
        final result = validation(null);
        expect(result, 'Must be required');
      });
    });
  });
}
