class IterableValidator {
  static String? notEmpty(Iterable value) =>
      value.isEmpty ? 'error_empty_input' : null;
}
