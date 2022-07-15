import 'package:lyform/lyform.dart';

/// {@template int_greater_than_validators}
/// Validate the `value` is greater than [limit].
///
/// If the provided `value` is less than or equal to [limit] then it will be
/// invalid and will return the error message, otherwise it returns null.
///
/// Example:
/// ```dart
/// final validation = IntGreaterThan(11, 'Must be greater than 11');
/// final result = validation(10);
/// print(result); // Must be greater than 11
///
/// ```
/// {@endtemplate}
class IntGreaterThan extends Validator<int> {
  /// {@macro int_greater_than_validators}
  IntGreaterThan(this.limit, String message) : super(message);

  /// The limit to compare the value to.
  final int limit;

  @override
  String? call(int value) => (value <= limit) ? message : null;
}

/// {@template int_greater_equal_than_validators}
/// Validate the `value` is greater than or equal to [limit].
///
/// If the provided `value` is less than [limit] then it will be invalid and
/// will return the error message, otherwise it returns null.
///
/// Example:
/// ```dart
/// final validation = IntGreaterEqualThan(11, 'Must be greater than or equal to 11');
/// final result = validation(10);
/// print(result); // Must be greater than or equal to 11
/// ```
class IntGreaterEqualThan extends Validator<int> {
  IntGreaterEqualThan(this.limit, String message) : super(message);

  /// The limit to compare the value to.
  final int limit;

  @override
  String? call(int value) => value < limit ? message : null;
}

/// {@template int_less_than_validators}
/// Validate the `value` is less than [limit].
///
/// If the provided `value` is lesser than [limit] then it will be
/// invalid and will return the error message, otherwise it returns null.
///
/// Example:
/// ```dart
/// final validation = IntLessThan(11, 'Must be less than 11');
/// final result = validation(15);
/// print(result); // Must be less than 11
/// ```
class IntLesserThan extends Validator<int> {
  /// {@macro int_less_than_validators}
  IntLesserThan(this.limit, String message) : super(message);

  /// The limit to compare the value to.
  final int limit;

  @override
  String? call(int value) => value >= limit ? message : null;
}

/// {@template int_less_equal_than_validators}
/// Validate the `value` is less than or equal to [limit].
///
/// If the provided `value` is lesser ot queal to than [limit] then it will be
/// invalid and will return the error message, otherwise it returns null.
///
/// Example:
/// ```dart
/// final validation = IntLessEqualThan(8, 'Must be less than or equal to 8');
/// final result = validation(10);
/// print(result); // Must be less than or equal to 8
/// ```
class IntLesserEquealThan extends Validator<int> {
  /// {@macro int_less_equal_than_validators}
  IntLesserEquealThan(this.limit, String message) : super(message);

  /// The limit to compare the value to.
  final int limit;

  @override
  String? call(int value) => value > limit ? message : null;
}

/// {@template int_non_negative_validators}
/// Validate the `value` is not negative.
///
/// If the provided `value` is negative then it will be invalid and will return
/// the error message, otherwise it returns null.
///
///  Example:
/// ```dart
/// final validation = IntNonNegative('Must be non negative');
/// final result = validation(-1);
/// print(result); // Must be non negative
/// ```
class IntNonNegative extends Validator<int> {
  /// {@macro int_non_negative_validators}
  IntNonNegative(super.message);

  @override
  String? call(int value) => value >= 0 ? null : message;
}
