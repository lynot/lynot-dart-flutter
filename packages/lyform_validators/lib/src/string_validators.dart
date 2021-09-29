import 'package:lyform/lyform.dart';
import 'package:validators/validators.dart' as validators;

class StringRequired extends Validator<String> {
  StringRequired(String message) : super(message);

  @override
  String? call(String value) => value.isEmpty ? message : null;
}

class StringLengthGreaterThan extends Validator<String> {
  StringLengthGreaterThan(String message, this.len) : super(message);

  final int len;

  @override
  String? call(String value) => value.length > len ? null : message;
}

class StringLengthLowerThan extends Validator<String> {
  StringLengthLowerThan(String message, this.len) : super(message);

  final int len;

  @override
  String? call(String value) => value.length < len ? null : message;
}

class StringPasswordMatch extends Validator<String> {
  StringPasswordMatch(String message, this.match) : super(message);

  final String Function() match;

  @override
  String? call(String value) => value != match() ? message : null;
}

class StringEquals extends Validator<String> {
  StringEquals(String message, this.comparison) : super(message);

  final dynamic comparison;

  @override
  String? call(String value) =>
      !validators.equals(value, comparison) ? message : null;
}

class StringContains extends Validator<String> {
  StringContains(String message, this.seed) : super(message);

  final dynamic seed;

  @override
  String? call(String value) =>
      !validators.contains(value, seed) ? message : null;
}

class StringMatches extends Validator<String> {
  StringMatches(String message, this.pattern) : super(message);

  final dynamic pattern;

  @override
  String? call(String value) =>
      !validators.matches(value, pattern) ? message : null;
}

class StringIsEmail extends Validator<String> {
  StringIsEmail(String message) : super(message);

  @override
  String? call(String value) => !validators.isEmail(value) ? message : null;
}

class StringIsURL extends Validator<String> {
  StringIsURL(
    String message, {
    this.protocols = const ['http', 'https', 'ftp'],
    this.requireTld = true,
    this.requireProtocol = false,
    this.allowUnderscore = false,
    this.hostWhitelist = const [],
    this.hostBlacklist = const [],
  }) : super(message);

  final List<String?> protocols;
  final bool requireTld;
  final bool requireProtocol;
  final bool allowUnderscore;
  final List<String> hostWhitelist;
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

class StringIsIP extends Validator<String> {
  StringIsIP(String message, this.version) : super(message);

  final dynamic version;

  @override
  String? call(String value) =>
      !validators.isIP(value, version) ? message : null;
}

class StringIsFQDN extends Validator<String> {
  StringIsFQDN(
    String message, [
    this.requireTld = true,
    this.allowUnderscores = false,
  ]) : super(message);

  final bool requireTld;
  final bool allowUnderscores;

  @override
  String? call(String value) => !validators.isFQDN(value) ? message : null;
}

class StringIsAlpha extends Validator<String> {
  StringIsAlpha(String message) : super(message);

  @override
  String? call(String value) => !validators.isAlpha(value) ? message : null;
}

class StringIsNumeric extends Validator<String> {
  StringIsNumeric(String message) : super(message);

  @override
  String? call(String value) => !validators.isNumeric(value) ? message : null;
}

class StringIsAlphanumeric extends Validator<String> {
  StringIsAlphanumeric(String message) : super(message);

  @override
  String? call(String value) =>
      !validators.isAlphanumeric(value) ? message : null;
}

class StringIsBase64 extends Validator<String> {
  StringIsBase64(String message) : super(message);

  @override
  String? call(String value) => !validators.isBase64(value) ? message : null;
}

class StringIsInt extends Validator<String> {
  StringIsInt(String message) : super(message);

  @override
  String? call(String value) => !validators.isInt(value) ? message : null;
}

class StringIsFloat extends Validator<String> {
  StringIsFloat(String message) : super(message);

  @override
  String? call(String value) => !validators.isFloat(value) ? message : null;
}

class StringIsHexadecimal extends Validator<String> {
  StringIsHexadecimal(String message) : super(message);

  @override
  String? call(String value) =>
      !validators.isHexadecimal(value) ? message : null;
}

class StringIsHexColor extends Validator<String> {
  StringIsHexColor(String message) : super(message);

  @override
  String? call(String value) => !validators.isHexColor(value) ? message : null;
}

class StringIsLowercase extends Validator<String> {
  StringIsLowercase(String message) : super(message);

  @override
  String? call(String value) => !validators.isLowercase(value) ? message : null;
}

class StringIsUppercase extends Validator<String> {
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
