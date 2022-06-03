import 'package:lyform/lyform.dart';
import 'package:validators/validators.dart' as validators;

/// {@template string_required_validator}
/// Validation that requires a string.
///
/// The [message] is returned when the value is empty.
/// {@endtemplate}
class StringRequired extends Validator<String> {
  /// {@macro string_required_validator}
  StringRequired(String message) : super(message);

  @override
  String? call(String value) => value.isEmpty ? message : null;
}

/// {@template string_length_greater_than_validator}
/// Validation that requires a string to have a minimum length.
///
/// If the value is shorter than [len] then return the [message],
/// otherwise it return null.
///
/// Example:
/// ```dart
/// final validation = StringLengthGreaterThan('Must be greater than 5', 5);
/// final result = validation('123');
/// print(result); // Must be greater than 5
/// ```
///
/// {@endtemplate}
class StringLengthGreaterThan extends Validator<String> {
  /// {@macro string_length_greater_than_validator}
  StringLengthGreaterThan(String message, this.len) : super(message);

  /// The minimum length of the string.
  final int len;

  @override
  String? call(String value) => value.length > len ? null : message;
}

/// {@template string_length_lower_than_validator}
/// Validation that requires a string to have a minimum length.
///
/// If the length of the value is not shorter than [len]
/// return [message], otherwise it will return a null value.
///
/// Example:
/// ```dart
/// final validation = StringLengthLowerThan(5, 'Must be at least 5 characters');
/// final result = validation('1234567');
/// print(result); // Must be at least 5 characters
/// ```
/// {@endtemplate}
class StringLengthLowerThan extends Validator<String> {
  /// {@macro string_length_lower_than_validator}
  StringLengthLowerThan(String message, this.len) : super(message);

  /// The length to compare the value to.
  final int len;

  @override
  String? call(String value) => value.length < len ? null : message;
}

/// {@template string_password_match_validator}
/// Validation that requires a string to match another string.
///
/// Example:
/// ```dart
/// final validator = StringPasswordMatch('Invalid password', () => 'abc');
/// final result = validation('123');
/// print(result); // Invalid password
/// ```
/// {@endtemplate}
class StringPasswordMatch extends Validator<String> {
  /// {@macro string_password_match_validator}
  StringPasswordMatch(String message, this.match) : super(message);

  /// The function that returns the value to compare the value to.
  final String Function() match;

  @override
  String? call(String value) => value != match() ? message : null;
}

/// {@template string_equals_validator}
/// Validation that requires a string to be equal to another string.
///
/// Example:
/// ```dart
/// final validator = StringEquals('Value not equals', 'abc');
/// final result = validation('efg');
/// print(result); // Value not equals
/// ```
/// {@endtemplate}
class StringEquals extends Validator<String> {
  /// {@macro string_equals_validator}
  StringEquals(String message, this.comparison) : super(message);

  /// The value to compare the value to.
  final dynamic comparison;

  @override
  String? call(String value) =>
      !validators.equals(value, comparison) ? message : null;
}

/// {@template string_contains_validator}
/// Validation that requires a string to contain another string.
///
/// If the value does not contain the [seed] then return the [message],
///
/// Example:
/// ```dart
/// final validator = StringContains('Value not contains', 'abc');
/// final result = validation('efg');
/// print(result); // Value not contains
/// ```
/// {@endtemplate}
class StringContains extends Validator<String> {
  /// {@macro string_contains_validator}
  StringContains(String message, this.seed) : super(message);

  /// The value to compare the value to.
  final dynamic seed;

  @override
  String? call(String value) =>
      !validators.contains(value, seed) ? message : null;
}

/// {@template string_matches_validator}
/// Validation that requires a string to match a regular expression.
///
/// If the value does not match the regular expression, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringMatches('Invalid email', r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
/// final result = validation('laura@mgail');
/// print(result); // Invalid email
/// ```
/// {@endtemplate}
class StringMatches extends Validator<String> {
  /// {@macro string_matches_validator}
  StringMatches(String message, this.pattern) : super(message);

  /// The regular expression to match the value against.
  final dynamic pattern;

  @override
  String? call(String value) =>
      !validators.matches(value, pattern) ? message : null;
}

/// {@template string_is_email_validator}
/// Validation that requires a string to be an email.
///
/// If the value is not an email, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsEmail('Invalid email');
/// final result = validation('laura@mgail');
/// print(result); // Invalid email
/// ```
/// {@endtemplate}
class StringIsEmail extends Validator<String> {
  /// {@macro string_is_email_validator}
  StringIsEmail(String message) : super(message);

  @override
  String? call(String value) => !validators.isEmail(value) ? message : null;
}

/// {@template string_is_url_validator}
/// Validation that requires a string to be an URL.
///
/// If the value is not an URL, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsUrl('Invalid URL');
/// final result = validation('https:/www.google.com');
/// print(result); // Invalid URL
/// ```
/// {@endtemplate}
class StringIsURL extends Validator<String> {
  /// {@macro string_is_url_validator}
  StringIsURL(
    String message, {
    this.protocols = const ['http', 'https', 'ftp'],
    this.requireTld = true,
    this.requireProtocol = false,
    this.allowUnderscore = false,
    this.hostWhitelist = const [],
    this.hostBlacklist = const [],
  }) : super(message);

  /// The protocols to allow.
  final List<String?> protocols;

  /// Whether to require a top-level domain.
  final bool requireTld;

  /// Whether to require a protocol.
  final bool requireProtocol;

  /// Whether to allow underscores in hostnames.
  final bool allowUnderscore;

  /// The hostname whitelist.
  final List<String> hostWhitelist;

  /// The hostname blacklist.
  final List<String> hostBlacklist;

  @override
  String? call(String value) => !validators.isURL(
        value,
        protocols: protocols,
        requireTld: requireTld,
        requireProtocol: requireProtocol,
        allowUnderscore: allowUnderscore,
        hostWhitelist: hostWhitelist,
        hostBlacklist: hostBlacklist,
      )
          ? message
          : null;
}

/// {@template string_is_ip_validator}
/// Validation that requires a string to be an IP address.
///
/// If the value is not an IP address, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsIP('Invalid IP');
/// final result = validation('16.51.1', 'v4');
/// print(result); // Invalid IP
/// ```
/// {@endtemplate}
class StringIsIP extends Validator<String> {
  /// {@macro string_is_ip_validator}
  StringIsIP(String message, this.version) : super(message);

  final dynamic version;

  @override
  String? call(String value) =>
      !validators.isIP(value, version) ? message : null;
}

/// {@template string_is_fqdn_validator}
/// Validation that requires a string to be a fully-qualified domain name.
///
/// If the value is not a fully-qualified domain name, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsFQDN('Invalid FQDN');
/// final result = validation('google,com');
/// print(result); // Invalid FQDN
/// ```
/// {@endtemplate}
class StringIsFQDN extends Validator<String> {
  /// {@macro string_is_fqdn_validator}
  StringIsFQDN(
    String message, [
    this.requireTld = true,
    this.allowUnderscores = false,
  ]) : super(message);

  /// Whether to require a top-level domain.
  final bool requireTld;

  /// Whether to allow underscores in hostnames.
  final bool allowUnderscores;

  @override
  String? call(String value) => !validators.isFQDN(value) ? message : null;
}

/// {@template string_is_alpha_validator}
/// Validation that requires a string to contain only letters (a-zA-Z).
///
/// If the value contains anything other than letters, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsAlpha('Invalid letters');
/// final result = validation('laura@mgail');
/// print(result); // Invalid letters
/// ```
/// {@endtemplate}
class StringIsAlpha extends Validator<String> {
  /// {@macro string_is_alpha_validator}
  StringIsAlpha(String message) : super(message);

  @override
  String? call(String value) => !validators.isAlpha(value) ? message : null;
}

/// {@template string_is_numeric_validator}
/// Validation that requires a string to contain only numbers.
///
/// If the value contains anything other than numbers, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsNumeric('Invalid numbers');
/// final result = validation('laura54');
/// print(result); // Invalid numbers
/// ```
/// {@endtemplate}
class StringIsNumeric extends Validator<String> {
  /// {@macro string_is_numeric_validator}
  StringIsNumeric(String message) : super(message);

  @override
  String? call(String value) => !validators.isNumeric(value) ? message : null;
}

/// {@template string_is_alphanumeric_validator}
/// Validation that requires a string to contain only numbers and letters.
///
/// If the value contains anything other than numbers and letters, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsAlphanumeric('Invalid alphanumeric');
/// final result = validation('abc@123');
/// print(result); // Invalid alphanumeric
/// ```
/// {@endtemplate}
class StringIsAlphanumeric extends Validator<String> {
  /// {@macro string_is_alphanumeric_validator}
  StringIsAlphanumeric(String message) : super(message);

  @override
  String? call(String value) =>
      !validators.isAlphanumeric(value) ? message : null;
}

/// {@template string_is_base64_validator}
/// Validation that requires a string to be base64 encoded.
///
/// If the value is not base64 encoded, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsBase64('Invalid base64');
/// final result = validation('YWJj123');
/// print(result); // Invalid base64
/// ```
/// {@endtemplate}
class StringIsBase64 extends Validator<String> {
  /// {@macro string_is_base64_validator}
  StringIsBase64(String message) : super(message);

  @override
  String? call(String value) => !validators.isBase64(value) ? message : null;
}

/// {@template string_is_int_validator}
/// Validation that requires a string to be an integer.
///
/// If the value is not an integer, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsInt('Invalid integer');
/// final result = validation('5.5');
/// print(result); // Invalid integer
/// ```
/// {@endtemplate}
class StringIsInt extends Validator<String> {
  /// {@macro string_is_int_validator}
  StringIsInt(String message) : super(message);

  @override
  String? call(String value) => !validators.isInt(value) ? message : null;
}

/// {@template string_is_float_validator}
/// Validation that requires a string to be a float.
///
/// If the value is not a float, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsFloat('Invalid float');
/// final result = validation('5');
/// print(result); // Invalid float
/// ```
/// {@endtemplate}
class StringIsFloat extends Validator<String> {
  /// {@macro string_is_float_validator}
  StringIsFloat(String message) : super(message);

  @override
  String? call(String value) => !validators.isFloat(value) ? message : null;
}

/// {@template string_is_hexadecimal_validator}
/// Validation that requires a string to be a hexadecimal number.
///
/// If the value is not a hexadecimal number, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsHexadecimal('Invalid hexadecimal');
/// final result = validation('5');
/// print(result); // Invalid hexadecimal
/// ```
///
/// {@endtemplate}
class StringIsHexadecimal extends Validator<String> {
  /// {@macro string_is_hexadecimal_validator}
  StringIsHexadecimal(String message) : super(message);

  @override
  String? call(String value) =>
      !validators.isHexadecimal(value) ? message : null;
}

/// {@template string_is_hexcolor_validator}
/// Validation that requires a string to be a hex color.
///
/// If the value is not a hex color, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsHexcolor('Invalid hex color');
/// final result = validation('#5');
/// print(result); // Invalid hex color
/// ```
/// {@endtemplate}
class StringIsHexColor extends Validator<String> {
  /// {@macro string_is_hexcolor_validator}
  StringIsHexColor(String message) : super(message);

  @override
  String? call(String value) => !validators.isHexColor(value) ? message : null;
}

/// {@template string_is_lower_case_validator}
/// Validation that requires a string to be lower case.
///
/// If the value is not lower case, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsLowerCase('Invalid lower case');
/// final result = validation('LOWER');
/// print(result); // Invalid lower case
/// ```
/// {@endtemplate}
class StringIsLowercase extends Validator<String> {
  /// {@macro string_is_lower_case_validator}
  StringIsLowercase(String message) : super(message);

  @override
  String? call(String value) => !validators.isLowercase(value) ? message : null;
}

/// {@template string_is_upper_case_validator}
/// Validation that requires a string to be upper case.
///
/// If the value is not upper case, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = StringIsUpperCase('Invalid upper case');
/// final result = validation('upper');
/// print(result); // Invalid upper case
/// ```
/// {@endtemplate}
class StringIsUppercase extends Validator<String> {
  /// {@macro string_is_upper_case_validator}
  StringIsUppercase(String message) : super(message);

  @override
  String? call(String value) => !validators.isUppercase(value) ? message : null;
}

// TODO: Finish implementation

// /// check if the string [value] is a number that's divisible by another
// ///
// /// [n] is a String or an int.
// static InputValidator<String?> isDivisibleBy({
//   required String message,
//   required int n,
// }) {
//   return (value) => !validators.isDivisibleBy(value, n)
//       ? message
//       : null;
// }

// /// check if the string [value] is null
// static InputValidator<String?> isNull({
//   required String message,
// }) {
//   return (value) => value != null ? message : null;
// }

// /// check if the length of the string [value] falls in a range
// static InputValidator<String?> isLength({
//   required String message,
//   required int min,
//   int? max,
// }) {
//   return (value) => !validators.isLength(value, min, max)
//       ? message
//       : null;
// }

// /// check if the string's length (in bytes) falls in a range.
// static InputValidator<String?> isByteLength({
//   required String message,
//   required int min,
//   int? max,
// }) {
//   return (value) => !validators.isByteLength(value, min, max)
//       ? message
//       : null;
// }

// /// check if the string is a UUID (version 3, 4 or 5).
// static InputValidator<String?> isUUID({
//   required String message,
//   dynamic version,
// }) {
//   return (value) => !validators.isUUID(value, version)
//       ? message
//       : null;
// }

// /// check if the string is a date
// static InputValidator<String?> isDate({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isDate(value) ? message : null;
// }

// /// check if the string is a date that's after the specified date
// ///
// /// If `date` is not passed, it defaults to now.
// static InputValidator<String?> isAfter({
//   required String message,
//   DateTime? date,
// }) {
//   return (value) =>
//       !validators.isAfter(value, date) ? message : null;
// }

// /// check if the string is a date that's before the specified date
// ///
// /// If `date` is not passed, it defaults to now.
// static InputValidator<String?> isBefore({
//   required String message,
//   DateTime? date,
// }) {
//   return (value) => !validators.isBefore(value, date)
//       ? message
//       : null;
// }

// /// check if the string is in a array of allowed values
// static InputValidator<String?> isIn({
//   required String message,
//   required Iterable<String> values,
// }) {
//   return (value) =>
//       !(validators.isIn(value, values) ?? false)
//           ? message
//           : null;
// }

// /// check if the string is a credit card
// static InputValidator<String?> isCreditCard({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isCreditCard(value) ? message : null;
// }

// // /// check if the string is an ISBN (version 10 or 13)
// static InputValidator<String?> isISBN({
//   required String message,
//   dynamic version,
// }) {
//   return (value) => !validators.isISBN(value, version)
//       ? message
//       : null;
// }

// /// check if the string is valid JSON
// static InputValidator<String?> isJSON({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isJSON(value) ? message : null;
// }

// /// check if the string contains one or more multibyte chars
// static InputValidator<String?> isMultibyte({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isMultibyte(value) ? message : null;
// }

// /// check if the string contains ASCII chars only
// static InputValidator<String?> isAscii({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isAscii(value) ? message : null;
// }

// /// check if the string contains any full-width chars
// static InputValidator<String?> isFullWidth({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isFullWidth(value) ? message : null;
// }

// /// check if the string contains any half-width chars
// static InputValidator<String?> isHalfWidth({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isHalfWidth(value) ? message : null;
// }

// /// check if the string contains a mixture of full and half-width chars
// static InputValidator<String?> isVariableWidth({
//   required String message,
// }) {
//   return (value) => !validators.isVariableWidth(value)
//       ? message
//       : null;
// }

// /// check if the string contains any surrogate pairs chars
// static InputValidator<String?> isSurrogatePair({
//   required String message,
// }) {
//   return (value) => !validators.isSurrogatePair(value)
//       ? message
//       : null;
// }

// /// check if the string is a valid hex-encoded representation of a MongoDB ObjectId
// static InputValidator<String?> isMongoId({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isMongoId(value) ? message : null;
// }

// static InputValidator<String?> isPostalCode({
//   required String message,
//   required String locale,
//   bool Function()? orElse,
// }) {
//   return (value) => value == null ||
//           !validators.isPostalCode(
//             value,
//             locale,
//             orElse: orElse,
//           )
//       ? message
//       : null;
// }
