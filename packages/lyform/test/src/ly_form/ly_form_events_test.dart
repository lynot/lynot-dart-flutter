// ignore_for_file: prefer_const_constructors

import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

void main() {
  final input1 = LyInput<String>(
    pureValue: '',
  );
  final input2 = LyInput<String>(
    pureValue: '',
  );
  final input3 = LyInput<String>(
    pureValue: '',
  );
  group('LyFormAddInputsEvent', () {
    test('supports value equality', () {
      final addInputEvent1 = LyFormAddInputsEvent([input1, input2]);
      final addInputEvent2 = LyFormAddInputsEvent([input1, input2]);

      expect(addInputEvent1, equals(addInputEvent2));
    });
  });

  group('LyFormAddInputEvent', () {
    test('supports value equality', () {
      final addInputEvent1 = LyFormAddInputEvent(0, input1);
      final addInputEvent2 = LyFormAddInputEvent(0, input1);

      expect(addInputEvent1, equals(addInputEvent2));
    });
  });

  group('LyFormRemoveInputEvent', () {
    test('supports value equality', () {
      final removeInputEvent1 = LyFormRemoveInputEvent(0);
      final removeInputEvent2 = LyFormRemoveInputEvent(0);

      expect(removeInputEvent1, equals(removeInputEvent2));
    });
  });

  group('LyFormChangedEvent', () {
    test('supports value equality', () {
      final changedEvent1 = LyFormChangedEvent('debugName');
      final changedEvent2 = LyFormChangedEvent('debugName');

      expect(changedEvent1, equals(changedEvent2));
    });
  });

  group('LyFormResetEvent', () {
    test('supports value equality', () {
      final resetEvent1 = LyFormResetEvent();
      final resetEvent2 = LyFormResetEvent();

      expect(resetEvent1, equals(resetEvent2));
    });
  });

  group('LyFormSubmitEvent', () {
    test('supports value equality', () {
      final submitEvent1 = LyFormSubmitEvent();
      final submitEvent2 = LyFormSubmitEvent();

      expect(submitEvent1, equals(submitEvent2));
    });
  });
}
