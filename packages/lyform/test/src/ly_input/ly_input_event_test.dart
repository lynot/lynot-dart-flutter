import 'package:lyform/lyform.dart';
import 'package:test/test.dart';

void main() {
  test('check the support equality', () {
    const inputEvent1 = LyInputDirtyEvent<String>('');
    const inputEvent2 = LyInputDirtyEvent<String>('');
    const inputEvent3 = LyInputPureEvent<String>('x');

    expect(inputEvent1, equals(inputEvent2));
    expect(inputEvent1, isNot(equals(inputEvent3)));
  });
}
