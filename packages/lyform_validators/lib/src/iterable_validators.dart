import 'package:lyform/lyform.dart';

class IterableValidator {
  static InputValidator<Iterable?> notEmpty({
    required String errorMessage,
  }) {
    return (value) => value == null || value.isEmpty ? errorMessage : null;
  }
}
