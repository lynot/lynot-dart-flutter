import 'package:lyform/lyform.dart';

class LyStringRequired extends LyValidator<String> {
  const LyStringRequired(super.message);

  @override
  String? call(String value) => value.isNotEmpty ? null : message;

  @override
  String toString() {
    return 'LyStringRequired(message: $message)';
  }
}

class TestForm extends LyForm<String, String> {
  TestForm() {
    addInputs([name]);
  }

  final name = LyInput<String>(
    pureValue: '',
    validationType: LyValidationType.always,
    validator: const LyStringRequired('Name is required.'),
    debugName: 'name',
  );

  @override
  Stream<LyFormState<String, String>> onSubmit() async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield success('Name save success!');
  }
}
