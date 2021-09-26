import 'package:lyform/lyform.dart';

class IntValidator {
  static InputValidator<int?> required({
    required String errorMessage,
  }) {
    return (value) => value == null ? errorMessage : null;
  }

  static InputValidator<int?> greaterThan({
    required int limit,
    required String errorMessage,
  }) {
    return (int? value) =>
        value == null || (value <= limit) ? errorMessage : null;
  }

  static InputValidator<int?> greaterEqualThan({
    required int limit,
    required String errorMessage,
  }) {
    return (int? value) {
      return value == null || (value < limit) ? errorMessage : null;
    };
  }

  static InputValidator<int?> lesserThan({
    required int limit,
    required String errorMessage,
  }) {
    return (int? value) =>
        value == null || (value >= limit) ? errorMessage : null;
  }

  static InputValidator<int?> lesserEquealThan({
    required int limit,
    required String errorMessage,
  }) {
    return (int? value) =>
        value == null || (value > limit) ? errorMessage : null;
  }

  static InputValidator<int?> nonNegative({
    required String errorMessage,
  }) {
    return (value) => value == null || value >= 0 ? null : errorMessage;
  }
}
