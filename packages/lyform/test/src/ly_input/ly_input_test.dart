import 'package:bloc_test/bloc_test.dart';
import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

void main() {
  test('should support equality', () {
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

  blocTest<LyInput<String>, LyInputState<String>>(
    'should emit new state in every `drity` call',
    build: () => LyInput<String>(pureValue: ''),
    act: (input) => input
      ..dirty('ly')
      ..dirty('')
      ..dirty('lyf'),
    wait: const Duration(seconds: 1),
    expect: () => [
      const LyInputState(
        value: 'ly',
        lastNotNullValue: 'ly',
        pureValue: '',
      ),
      const LyInputState(
        value: '',
        lastNotNullValue: '',
        pureValue: '',
      ),
      const LyInputState(
        value: 'lyf',
        lastNotNullValue: 'lyf',
        pureValue: '',
      ),
    ],
  );
}
