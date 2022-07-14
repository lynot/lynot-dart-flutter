import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:lyform_validators/lyform_validators.dart';

class ProfileForm extends FormBloc<String, String> {
  final email = InputCubit<String>(
    pureValue: '',
    validationType: ValidationType.always,
    validator: StringRequired('Email is required.') &
        StringIsEmail('Email is not valid.'),
    debugName: 'email',
  );

  final name = InputCubit<String>(
    pureValue: '',
    validationType: ValidationType.always,
    validator: StringRequired('Name is required.'),
    debugName: 'name',
  );

  final age = InputCubit<int>(
    pureValue: 0,
    validationType: ValidationType.always,
    validator: IntGreaterThan(
      0,
      'Order in course must be greater or equal than 0.',
    ),
    debugName: 'age',
  );

  final country = InputCubit<String?>(
    pureValue: null,
  );

  @override
  List<InputBase> get inputs => [name, email, country, age];

  @override
  Stream<FormBlocState<String, String>> onSubmit() async* {
    await Future<void>.delayed(const Duration(seconds: 3));
    yield const FormSuccessState('Profile save successfully.');
  }
}
