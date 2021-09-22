class Validator {
  static String? required(dynamic value) =>
      value == null ? 'error_empty_input' : null;
}
