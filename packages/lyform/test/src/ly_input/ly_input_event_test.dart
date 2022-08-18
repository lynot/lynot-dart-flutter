// ignore_for_file: prefer_const_constructors

import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

void main() {
  group('LyInput', () {
    test('check support equality in `LyInputPureEvent`', () {
      final event1 = LyInputPureEvent<String>('value');
      final event2 = LyInputPureEvent<String>('value');
      final event3 = LyInputPureEvent<String>('value3');

      expect(event1, equals(event2));
      expect(event1, isNot(equals(event3)));
    });

    test('check support equality in `LyInputDirtyEvent`', () {
      final inputEvent1 = LyInputDirtyEvent<String>('');
      final inputEvent2 = LyInputDirtyEvent<String>('');
      final inputEvent3 = LyInputDirtyEvent<String>('x');

      expect(inputEvent1, equals(inputEvent2));
      expect(inputEvent1, isNot(equals(inputEvent3)));
    });

    test('check support equality in `LyInputValidateEvent`', () {
      final inputEvent1 = LyInputValidateEvent<String>();
      final inputEvent2 = LyInputValidateEvent<String>();

      expect(inputEvent1, equals(inputEvent2));
    });
  });
}
