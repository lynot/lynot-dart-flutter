import 'package:lyform/lyform.dart';

class Validator {
  static InputValidator<dynamic> required({
    required String errorMessage,
  }) {
    return (value) => value == null ? errorMessage : null;
  }
}
