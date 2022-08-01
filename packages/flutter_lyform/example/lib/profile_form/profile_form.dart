import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:lyform_validators/lyform_validators.dart';

class ProfileForm extends LyForm<String, String> {
  ProfileForm() {
    addInputs([name, email, country, age]);
  }

  final email = LyInput<String>(
    pureValue: '',
    validationType: LyValidationType.always,
    validator: LyStringRequired('Email is required.') &
        LyStringIsEmail('Email is not valid.'),
    debugName: 'email',
  );

  final name = LyInput<String>(
    pureValue: '',
    validationType: LyValidationType.always,
    validator: LyStringRequired('Name is required.'),
    debugName: 'name',
  );

  final age = LyInput<int>(
    pureValue: 0,
    validationType: LyValidationType.always,
    validator: LyIntGreaterThan(
      0,
      'Order in course must be greater or equal than 0.',
    ),
    debugName: 'age',
  );

  final country = LyInput<String?>(
    pureValue: null,
  );

  @override
  Stream<LyFormState<String, String>> onSubmit() async* {
    await Future<void>.delayed(const Duration(seconds: 3));
    yield const LyFormSuccessState('Profile save successfully.');
  }
}
