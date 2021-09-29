import 'package:lyform/lyform.dart';

class GeneralValidator {
  static InputValidator<dynamic> required({
    required String errorMessage,
  }) {
    return (value) => value == null ? errorMessage : null;
  }
}
