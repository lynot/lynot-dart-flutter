import 'package:lyform_validators/src/iterable_validators.dart';
import 'package:test/test.dart';

void main() {
  group('Iterable Validators', () {
    group('IterableNotEmtpy', () {
      test('should return `null` when the `value` is not null', () {
        final validation = LyIterableNotEmtpy('The list not be empty');
        final result = validation([1, 2, 3]);
        expect(result, isNull);
      });

      test('should return a `message` when the `value` is null', () {
        final validation = LyIterableNotEmtpy('The list not be empty');
        final result = validation([]);
        expect(result, 'The list not be empty');
      });
    });
  });
}
