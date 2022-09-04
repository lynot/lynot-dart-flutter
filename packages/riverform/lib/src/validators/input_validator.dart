export 'custom_validator.dart';

abstract class InputValidator<T> {
  const InputValidator();
  Future<String?> validate(T? value);
}
