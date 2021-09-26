import 'package:lyform/lyform.dart';

class IterableValidator {
  static InputValidator<Iterable> notEmpty({
    required String errorMessage,
  }) {
    return (value) => value.isEmpty ? errorMessage : null;
  }
}
