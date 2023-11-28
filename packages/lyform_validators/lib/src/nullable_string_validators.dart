import 'package:lyform/lyform.dart';
import 'package:validators/validators.dart' as validators;

/// {@template nullable_string_length_greater_than_validator}
/// Validate the `value` is greater than `minLength`.
///
/// If the provided string in `value` is less than `minLength` then it will
/// be invalid and will return the error message, otherwise it returns null.
/// {@endtemplate}
class LyNullableStringLengthGreaterThan extends LyValidator<String?> {
  /// {@macro nullable_string_length_greater_than_validator}
  LyNullableStringLengthGreaterThan(super.message, this.minLength);

  /// The minimum length of the string.
  final int minLength;

  @override
  String? call(String? value) => value == null
      ? null
      : value.length > minLength
          ? null
          : message;
}

/// {@template nullable_string_length_lower_than_validator}
/// Validate the `value` is lower than `maxLength`.
///
/// If the provided string in `value` is greater than `maxLength` then it will
/// be invalid and will return the error message, otherwise it returns null.
/// {@endtemplate}
class LyNullableStringLengthLowerThan extends LyValidator<String?> {
  /// {@macro nullable_string_length_lower_than_validator}
  LyNullableStringLengthLowerThan(super.message, this.maxLength);

  /// The maximum length of the string.
  final int maxLength;

  @override
  String? call(String? value) => value == null
      ? null
      : value.length < maxLength
          ? null
          : message;
}

/// {@template nullable_string_password_match_validator}
/// Validation that requires a string to match another string.
///
/// This validator is commonly used for validating passwords to make sure they
/// match.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringPasswordMatch('Invalid password', () => 'abc');
/// final result = validation('123');
/// print(result); // Invalid password
/// ```
/// {@endtemplate}
class LyNullableStringPasswordMatch extends LyValidator<String?> {
  /// {@macro nullable_string_password_match_validator}
  LyNullableStringPasswordMatch(super.message, this.match);

  /// The function that is used to match the password.
  final String Function() match;

  @override
  String? call(String? value) => value == null
      ? null
      : value != match()
          ? message
          : null;
}

/// {@template nullable_string_equals_validator}
/// Validation that requires a string to match another string.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringEquals('Value not equals', 'abc');
/// final result = validation('efg');
/// print(result); // Value not equals
/// ```
/// {@endtemplate}
class LyNullableStringEquals extends LyValidator<String?> {
  /// {@macro nullable_string_equals_validator}
  LyNullableStringEquals(super.message, this.comparison);

  /// The string that is compared to the [value] to determine if it is valid
  /// or not.
  final dynamic comparison;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.equals(value, comparison)
          ? message
          : null;
}

/// {@template nullable_string_contains_validator}
/// Validation that a string contains in another string.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringContains('Value not contains', 'Hello');
/// final result = validation('abc');
/// print(result); // Value not contains
/// ```
/// {@endtemplate}
class LyNullableStringContains extends LyValidator<String?> {
  /// {@macro nullable_string_contains_validator}
  LyNullableStringContains(super.message, this.seed);

  /// Seed that is used to determine if the [value] contains the [seed] or not.
  final dynamic seed;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.contains(value, seed)
          ? message
          : null;
}

/// {@template nullable_string_matches_validator}
/// Validation that requires a string to match a regular expression.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringMatches('Invalid email', r'^[a-zA-Z0-9]*$');
/// final result = validation('abc');
/// print(result); // Invalid email
/// ```
/// {@endtemplate}
class LyNullableStringMatches extends LyValidator<String?> {
  /// {@macro nullable_string_matches_validator}
  LyNullableStringMatches(super.message, this.pattern);

  /// The regular expression that is used to determine if the [value] matches.
  final dynamic pattern;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.matches(value, pattern)
          ? message
          : null;
}

/// {@template nullable_string_is_email_validator}
/// Validation that requires a string to be an email.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsEmail('Invalid email');
/// final result = validation('laura@gmail');
/// print(result); // Invalid email
/// ```
/// {@endtemplate}
class LyNullableStringIsEmail extends LyValidator<String?> {
  /// {@macro nullable_string_is_email_validator}
  LyNullableStringIsEmail(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isEmail(value)
          ? message
          : null;
}

/// {@template nullable_string_is_url_validator}
/// Validation that requires a string to be an url.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsUrl('Invalid url');
/// final result = validation('https:/www.google.com');
/// ```
/// {@endtemplate}
class LyNullableStringIsURL extends LyValidator<String?> {
  /// {@macro nullable_string_is_url_validator}
  LyNullableStringIsURL(
    super.message, {
    this.protocols = const ['http', 'https', 'ftp'],
    this.requireTld = true,
    this.requireProtocol = false,
    this.allowUnderscore = false,
    this.hostWhitelist = const [],
    this.hostBlacklist = const [],
  });

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
  String? call(String? value) => value == null
      ? null
      : !validators.isURL(
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

/// {@template nullable_string_is_ip_validator}
/// Validation that requires a string to be an ip.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsIP('Invalid ip', '4');
/// final result = validation('16.51.1');
/// print(result); // Invalid ip
/// ```
/// {@endtemplate}
class LyNullableStringIsIP extends LyValidator<String?> {
  LyNullableStringIsIP(super.message, this.version);

  final dynamic version;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isIP(value, version)
          ? message
          : null;
}

/// {@template nullable_string_is_fqdn_validator}
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
class LyNullableStringIsFQDN extends LyValidator<String?> {
  /// {@macro nullable_string_is_fqdn_validator}
  LyNullableStringIsFQDN(
    super.message, [
    this.requireTld = true,
    this.allowUnderscores = false,
  ]);

  /// Whether to require a top-level domain.
  final bool requireTld;

  /// Whether to allow underscores in hostnames.
  final bool allowUnderscores;
  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isFQDN(value)
          ? message
          : null;
}

/// {@template nullable_string_is_alpha_validator}
/// Validation that requires a string to contain only letters (a-zA-Z).
///
/// If the value contains anything other than letters, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsAlpha('Invalid alpha');
/// final result = validation('abc123');
/// print(result); // Invalid alpha
/// ```
/// {@endtemplate}
class LyNullableStringIsAlpha extends LyValidator<String?> {
  /// {@macro nullable_string_is_alpha_validator}
  LyNullableStringIsAlpha(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isAlpha(value)
          ? message
          : null;
}

/// {@template nullable_string_is_numeric_validator}
/// Validation that requires a string to contain only numbers.
///
/// If the value contains anything other than numbers, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsNumeric('Invalid numeric');
/// final result = validation('abc123');
/// print(result); // Invalid numeric
/// ```
/// {@endtemplate}
class LyNullableStringIsNumeric extends LyValidator<String?> {
  /// {@macro nullable_string_is_numeric_validator}
  LyNullableStringIsNumeric(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isNumeric(value)
          ? message
          : null;
}

/// {@template nullable_string_is_alphanumeric_validator}
/// Validation that requires a string to contain only numbers and letters.
///
/// If the value contains anything other than numbers and letters, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsAlphanumeric('Invalid alphanumeric');
/// final result = validation('abc@123');
/// print(result); // Invalid alphanumeric
/// ```
/// {@endtemplate}
class LyNullableStringIsAlphanumeric extends LyValidator<String?> {
  /// {@macro nullable_string_is_alphanumeric_validator}
  LyNullableStringIsAlphanumeric(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isAlphanumeric(value)
          ? message
          : null;
}

/// {@template nullable_string_is_base64_validator}
/// Validation that requires a string to be base64 encoded.
///
/// If the value is not base64 encoded, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsBase64('Invalid base64');
/// final result = validation('YWJjMTIzQ==');
/// print(result); // Invalid base64
/// ```
/// {@endtemplate}
class LyNullableStringIsBase64 extends LyValidator<String?> {
  /// {@macro nullable_string_is_base64_validator}
  LyNullableStringIsBase64(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isBase64(value)
          ? message
          : null;
}

/// {@template nullable_string_is_int_validator}
/// Validation that requires a string to be an integer.
///
/// If the value is not an integer, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsInt('Invalid integer');
/// final result = validation('5.5');
/// print(result); // Invalid integer
/// ```
/// {@endtemplate}
class LyNullableStringIsInt extends LyValidator<String?> {
  /// {@macro nullable_string_is_int_validator}
  LyNullableStringIsInt(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isInt(value)
          ? message
          : null;
}

/// {@template nullable_string_is_float_validator}
/// Validation that requires a string to be a float.
///
/// If the value is not a float, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsFloat('Invalid float');
/// final result = validation('H1A01');
/// print(result); // Invalid float
/// ```
/// {@endtemplate}
class LyNullableStringIsFloat extends LyValidator<String?> {
  /// {@macro nullable_string_is_float_validator}
  LyNullableStringIsFloat(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isFloat(value)
          ? message
          : null;
}

/// {@template nullable_string_is_hexadecimal_validator}
/// Validation that requires a string to be a hexadecimal number.
///
/// If the value is not a hexadecimal number, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsHexadecimal('Invalid hexadecimal');
/// final result = validation('5');
/// print(result); // Invalid hexadecimal
/// ```
///
/// {@endtemplate}
class LyNullableStringIsHexadecimal extends LyValidator<String?> {
  /// {@macro nullable_string_is_hexadecimal_validator}
  LyNullableStringIsHexadecimal(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isHexadecimal(value)
          ? message
          : null;
}

/// {@template nullable_string_is_hexcolor_validator}
/// Validation that requires a string to be a hex color.
///
/// If the value is not a hex color, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsHexColor('Invalid hex color');
/// final result = validation('#5');
/// print(result); // Invalid hex color
/// ```
/// {@endtemplate}
class LyNullableStringIsHexColor extends LyValidator<String?> {
  /// {@macro nullable_string_is_hexcolor_validator}
  LyNullableStringIsHexColor(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isHexColor(value)
          ? message
          : null;
}

/// {@template nullable_string_is_lower_case_validator}
/// Validation that requires a string to be lower case.
///
/// If the value is not lower case, the [message] is returned.
///
/// Example:
/// ```dart
/// final validator = LyNullableStringIsLowercase('Invalid lower case');
/// final result = validation('LOWER');
/// print(result); // Invalid lower case
/// ```
/// {@endtemplate}
class LyNullableStringIsLowercase extends LyValidator<String?> {
  /// {@macro nullable_string_is_lower_case_validator}
  LyNullableStringIsLowercase(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isLowercase(value)
          ? message
          : null;
}

/// {@template nullable_string_is_upper_case_validator}
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
class LyNullableStringIsUppercase extends LyValidator<String?> {
  /// {@macro nullable_string_is_upper_case_validator}
  LyNullableStringIsUppercase(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isUppercase(value)
          ? message
          : null;
}
