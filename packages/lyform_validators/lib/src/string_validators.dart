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

  // /// check if the string [value] is a fully qualified domain name (e.g. domain.com).
  // ///
  // /// * [requireTld] sets if TLD is required
  // /// * [allowUnderscore] sets if underscores are allowed
  // bool isFQDN(
  //   String value, {
  //   bool requireTld = true,
  //   bool allowUnderscores = false,
  // }) {}

  // /// check if the string [value] contains only letters (a-zA-Z).
  // bool isAlpha(value) {}

  // /// check if the string [value] contains only numbers
  // bool isNumeric(value) {}

  // /// check if the string [value] contains only letters and numbers
  // bool isAlphanumeric(value) {}

  // /// check if a string [value] is base64 encoded
  // bool isBase64(value) {}

  // /// check if the string [value] is an integer
  // bool isInt(value) {}

  // /// check if the string [value] is a float
  // bool isFloat(value) {}

  // /// check if the string  [value]is a hexadecimal number
  // bool isHexadecimal(value) {}

  // /// check if the string [value] is a hexadecimal color
  // bool isHexColor(value) {}

  // /// check if the string [value] is lowercase
  // bool isLowercase(value) {}

  // /// check if the string [value] is uppercase
  // bool isUppercase(value) {}

  // /// check if the string [value] is a number that's divisible by another
  // ///
  // /// [n] is a String or an int.
  // bool isDivisibleBy(String value, n) {}

  // /// check if the string [value] is null
  // bool isNull(String? value) {}

  // /// check if the length of the string [value] falls in a range
  // bool isLength(String value, int min, [int? max]) {}

  // /// check if the string's length (in bytes) falls in a range.
  // bool isByteLength(String value, int min, [int? max]) {}

  // /// check if the string is a UUID (version 3, 4 or 5).
  // bool isUUID(String? value, [version]) {}

  // /// check if the string is a date
  // bool isDate(value) {}

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

  // /// check if the string is a credit card
  // bool isCreditCard(value) {}

  // /// check if the string is an ISBN (version 10 or 13)
  // bool isISBN(String? value, [version]) {}

  // /// check if the string is valid JSON
  // bool isJSON(value) {}

  // /// check if the string contains one or more multibyte chars
  // bool isMultibyte(value) {}

  // /// check if the string contains ASCII chars only
  // bool isAscii(value) {}

  // /// check if the string contains any full-width chars
  // bool isFullWidth(value) {}

  // /// check if the string contains any half-width chars
  // bool isHalfWidth(value) {}

  // /// check if the string contains a mixture of full and half-width chars
  // bool isVariableWidth(value) {}

  // /// check if the string contains any surrogate pairs chars
  // bool isSurrogatePair(value) {}

  // /// check if the string is a valid hex-encoded representation of a MongoDB ObjectId
  // bool isMongoId(value) {}

  // bool isPostalCode(String? text, String locale, {bool orElse()?}) {}
}
