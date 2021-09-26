import 'package:lyform/lyform.dart';
import 'package:validators/validators.dart' as validators;

class StringValidator {
  /// assert when [value] is [null] or is not empty
  static InputValidator<String?> required({
    required String errorMessage,
  }) {
    return (value) => value != null && value.isEmpty ? errorMessage : null;
  }

  static InputValidator<String?> lengthGreaterThan({
    required int len,
    required String errorMessage,
  }) {
    return (value) => value != null && value.length > len ? null : errorMessage;
  }

  static InputValidator<String?> lengthLowerThan({
    required int len,
    required String errorMessage,
  }) {
    return (value) => value != null && value.length < len ? null : errorMessage;
  }

  static InputValidator<String?> stringPasswordMatch({
    required String Function() match,
    required String errorMessage,
  }) {
    return (value) => value != match() ? errorMessage : null;
  }

  /// check if the string matches the comparison
  static InputValidator<String?> equals({
    required dynamic comparison,
    required String errorMessage,
  }) {
    return (value) =>
        !validators.equals(value, comparison) ? errorMessage : null;
  }

  /// check if the string contains the seed
  static InputValidator<String?> contains({
    required dynamic seed,
    required String errorMessage,
  }) {
    return (value) => value != null && !validators.contains(value, seed)
        ? errorMessage
        : null;
  }

  /// check if string [value] matches the [pattern].
  static InputValidator<String?> matches({
    required dynamic pattern,
    required String errorMessage,
  }) {
    return (value) => value != null && !validators.matches(value, pattern)
        ? errorMessage
        : null;
  }

  /// check if the string [value] is an email
  static InputValidator<String?> isEmail({
    required String errorMessage,
  }) {
    return (value) =>
        value != null && !validators.isEmail(value) ? errorMessage : null;
  }

  /// check if the string [value] is a URL
  ///
  /// * [protocols] sets the list of allowed protocols
  /// * [requireTld] sets if TLD is required
  /// * [requireProtocol] is a `bool` that sets if protocol is required for validation
  /// * [allowUnderscore] sets if underscores are allowed
  /// * [hostWhitelist] sets the list of allowed hosts
  /// * [hostBlacklist] sets the list of disallowed hosts
  static InputValidator<String?> isURL({
    required String errorMessage,
    List<String?> protocols = const ['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const [],
    List<String> hostBlacklist = const [],
  }) {
    return (value) => !validators.isURL(
          value,
          protocols: protocols,
          requireTld: requireTld,
          requireProtocol: requireProtocol,
          allowUnderscore: allowUnderscore,
          hostWhitelist: hostWhitelist,
          hostBlacklist: hostBlacklist,
        )
            ? errorMessage
            : null;
  }

  /// check if the string [value] is IP [version] 4 or 6
  ///
  /// * [version] is a String or an `int`.
  static InputValidator<String?> isIP({
    /*<String | int>*/ required dynamic version,
    required String errorMessage,
  }) {
    return (value) => !validators.isIP(value, version) ? errorMessage : null;
  }

  /// check if the string [value] is a fully qualified domain name (e.g. domain.com).
  ///
  /// * [requireTld] sets if TLD is required
  /// * [allowUnderscore] sets if underscores are allowed
  static InputValidator<String?> isFQDN({
    required String errorMessage,
    bool requireTld = true,
    bool allowUnderscores = false,
  }) {
    return (value) =>
        value == null || !validators.isFQDN(value) ? errorMessage : null;
  }

  /// check if the string [value] contains only letters (a-zA-Z).
  static InputValidator<String?> isAlpha({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isAlpha(value) ? errorMessage : null;
  }

  /// check if the string [value] contains only numbers
  static InputValidator<String?> isNumeric({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isNumeric(value) ? errorMessage : null;
  }

  /// check if the string [value] contains only letters and numbers
  static InputValidator<String?> isAlphanumeric({
    required String errorMessage,
  }) {
    return (value) => value == null || !validators.isAlphanumeric(value)
        ? errorMessage
        : null;
  }

  /// check if a string [value] is base64 encoded
  static InputValidator<String?> isBase64({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isBase64(value) ? errorMessage : null;
  }

  /// check if the string [value] is an integer
  static InputValidator<String?> isInt({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isInt(value) ? errorMessage : null;
  }

  /// check if the string [value] is a float
  static InputValidator<String?> isFloat({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isFloat(value) ? errorMessage : null;
  }

  /// check if the string  [value]is a hexadecimal number
  static InputValidator<String?> isHexadecimal({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isHexadecimal(value) ? errorMessage : null;
  }

  /// check if the string [value] is a hexadecimal color
  static InputValidator<String?> isHexColor({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isHexColor(value) ? errorMessage : null;
  }

  /// check if the string [value] is lowercase
  static InputValidator<String?> isLowercase({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isLowercase(value) ? errorMessage : null;
  }

  /// check if the string [value] is uppercase
  static InputValidator<String?> isUppercase({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isUppercase(value) ? errorMessage : null;
  }

  // /// check if the string [value] is a number that's divisible by another
  // ///
  // /// [n] is a String or an int.
  // bool isDivisibleBy(String value, n) {}

  /// check if the string [value] is null
  static InputValidator<String?> isNull({
    required String errorMessage,
  }) {
    return (value) => value != null ? errorMessage : null;
  }

  // /// check if the length of the string [value] falls in a range
  // bool isLength(String value, int min, [int? max]) {}

  // /// check if the string's length (in bytes) falls in a range.
  // bool isByteLength(String value, int min, [int? max]) {}

  // /// check if the string is a UUID (version 3, 4 or 5).
  // bool isUUID(String? value, [version]) {}

  /// check if the string is a date
  static InputValidator<String?> isDate({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isDate(value) ? errorMessage : null;
  }

  // /// check if the string is a date that's after the specified date
  // ///
  // /// If `date` is not passed, it defaults to now.
  // bool isAfter(String? value, [date]) {}

  // /// check if the string is a date that's before the specified date
  // ///
  // /// If `date` is not passed, it defaults to now.
  // bool isBefore(String? value, [date]) {}

  // /// check if the string is in a array of allowed values
  // bool? isIn(String? value, values) {}

  /// check if the string is a credit card
  static InputValidator<String?> isCreditCard({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isCreditCard(value) ? errorMessage : null;
  }

  // /// check if the string is an ISBN (version 10 or 13)
  // bool isISBN(String? value, [version]) {}

  /// check if the string is valid JSON
  static InputValidator<String?> isJSON({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isJSON(value) ? errorMessage : null;
  }

  /// check if the string contains one or more multibyte chars
  static InputValidator<String?> isMultibyte({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isMultibyte(value) ? errorMessage : null;
  }

  /// check if the string contains ASCII chars only
  static InputValidator<String?> isAscii({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isAscii(value) ? errorMessage : null;
  }

  /// check if the string contains any full-width chars
  static InputValidator<String?> isFullWidth({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isFullWidth(value) ? errorMessage : null;
  }

  /// check if the string contains any half-width chars
  static InputValidator<String?> isHalfWidth({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isHalfWidth(value) ? errorMessage : null;
  }

  /// check if the string contains a mixture of full and half-width chars
  static InputValidator<String?> isVariableWidth({
    required String errorMessage,
  }) {
    return (value) => value == null || !validators.isVariableWidth(value)
        ? errorMessage
        : null;
  }

  /// check if the string contains any surrogate pairs chars
  static InputValidator<String?> isSurrogatePair({
    required String errorMessage,
  }) {
    return (value) => value == null || !validators.isSurrogatePair(value)
        ? errorMessage
        : null;
  }

  /// check if the string is a valid hex-encoded representation of a MongoDB ObjectId
  static InputValidator<String?> isMongoId({
    required String errorMessage,
  }) {
    return (value) =>
        value == null || !validators.isMongoId(value) ? errorMessage : null;
  }

  // bool isPostalCode(String? text, String locale, {bool orElse()?}) {}
}
