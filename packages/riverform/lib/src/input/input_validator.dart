abstract class InputValidator<T> {
  const InputValidator();
  Future<String?> validate(T? value);
}
