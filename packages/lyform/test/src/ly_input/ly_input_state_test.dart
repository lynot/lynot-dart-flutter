import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

void main() {
  test('check the support equality', () {
    const inputState1 = LyInputState<String>(
      value: '',
      lastNotNullValue: '',
      pureValue: '',
      debugName: 'name',
    );
    const inputState2 = LyInputState<String>(
      value: '',
      lastNotNullValue: '',
      pureValue: '',
      debugName: 'name',
    );
    const inputState3 = LyInputState<String>(
      value: '',
      lastNotNullValue: '',
      pureValue: '',
      debugName: 'different name',
    );

    expect(inputState1, equals(inputState2));
    expect(inputState1, isNot(equals(inputState3)));
  });
}
