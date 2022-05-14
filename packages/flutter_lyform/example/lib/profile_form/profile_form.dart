import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:lyform_validators/lyform_validators.dart';

class ProfileForm extends FormBloc<String, String> {
  final email = InputBloc<String>(
    pureValue: '',
    validationType: ValidationType.always,
    validator: StringRequired('Email is required.') &
        StringIsEmail('Email is not valid.'),
    debugName: 'email',
  );
  final name = InputBloc<String>(
    pureValue: '',
    validationType: ValidationType.always,
    validator: StringRequired('Password is required.') &
        StringLengthGreaterThan('Name must be at least 6 characters.', 6),
    debugName: 'name',
  );
  final age = InputBloc<int>(
      pureValue: 0,
      validationType: ValidationType.always,
      validator: IntGreaterThan(
        0,
        'Order in course must be greater or equal than 0.',
      ),
      debugName: 'age');
  final country = InputBloc<String?>(
    pureValue: null,
  );
  final emailSubcription =
      InputBloc<bool>(pureValue: false, debugName: 'emailSubcription');

  @override
  List<InputBloc> get inputs => [name, email, emailSubcription, country, age];

  @override
  Future<FormBlocState<String, String>> onSubmmit() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return const FormSuccessState('Profile save successfully.');
  }
}
