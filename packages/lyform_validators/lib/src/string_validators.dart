import 'package:lyform/lyform.dart';
import 'package:validators/validators.dart' as validators;

class LyStringRequired extends LyValidator<String> {
  LyStringRequired(super.message);

  @override
  String? call(String value) => value.isEmpty ? message : null;
}

class LyStringLengthGreaterThan extends LyValidator<String> {
  LyStringLengthGreaterThan(super.message, this.len);

  final int len;

  @override
  String? call(String value) => value.length > len ? null : message;
}

class LyStringLengthLowerThan extends LyValidator<String> {
  LyStringLengthLowerThan(super.message, this.len);

  final int len;

  @override
  String? call(String value) => value.length < len ? null : message;
}

class LyStringPasswordMatch extends LyValidator<String> {
  LyStringPasswordMatch(super.message, this.match);

  final String Function() match;

  @override
  String? call(String value) => value != match() ? message : null;
}

class LyStringEquals extends LyValidator<String> {
  LyStringEquals(super.message, this.comparison);

  final dynamic comparison;

  @override
  String? call(String value) =>
      !validators.equals(value, comparison) ? message : null;
}

class LyStringContains extends LyValidator<String> {
  LyStringContains(super.message, this.seed);

  final dynamic seed;

  @override
  String? call(String value) =>
      !validators.contains(value, seed) ? message : null;
}

class LyStringMatches extends LyValidator<String> {
  LyStringMatches(super.message, this.pattern);

  final dynamic pattern;

  @override
  String? call(String value) =>
      !validators.matches(value, pattern) ? message : null;
}

class LyStringIsEmail extends LyValidator<String> {
  LyStringIsEmail(super.message);

  @override
  String? call(String value) => !validators.isEmail(value) ? message : null;
}

class LyStringIsURL extends LyValidator<String> {
  LyStringIsURL(
    super.message, {
    this.protocols = const ['http', 'https', 'ftp'],
    this.requireTld = true,
    this.requireProtocol = false,
    this.allowUnderscore = false,
    this.hostWhitelist = const [],
    this.hostBlacklist = const [],
  });

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

class LyStringIsIP extends LyValidator<String> {
  LyStringIsIP(super.message, this.version);

  final dynamic version;

  @override
  String? call(String value) =>
      !validators.isIP(value, version) ? message : null;
}

class LyStringIsFQDN extends LyValidator<String> {
  LyStringIsFQDN(
    super.message, [
    this.requireTld = true,
    this.allowUnderscores = false,
  ]);

  final bool requireTld;
  final bool allowUnderscores;

  @override
  String? call(String value) => !validators.isFQDN(value) ? message : null;
}

class LyStringIsAlpha extends LyValidator<String> {
  LyStringIsAlpha(super.message);

  @override
  String? call(String value) => !validators.isAlpha(value) ? message : null;
}

class LyStringIsNumeric extends LyValidator<String> {
  LyStringIsNumeric(super.message);

  @override
  String? call(String value) => !validators.isNumeric(value) ? message : null;
}

class LyStringIsAlphanumeric extends LyValidator<String> {
  LyStringIsAlphanumeric(super.message);

  @override
  String? call(String value) =>
      !validators.isAlphanumeric(value) ? message : null;
}

class LyStringIsBase64 extends LyValidator<String> {
  LyStringIsBase64(super.message);

  @override
  String? call(String value) => !validators.isBase64(value) ? message : null;
}

class LyStringIsInt extends LyValidator<String> {
  LyStringIsInt(super.message);

  @override
  String? call(String value) => !validators.isInt(value) ? message : null;
}

class LyStringIsFloat extends LyValidator<String> {
  LyStringIsFloat(super.message);

  @override
  String? call(String value) => !validators.isFloat(value) ? message : null;
}

class LyStringIsHexadecimal extends LyValidator<String> {
  LyStringIsHexadecimal(super.message);

  @override
  String? call(String value) =>
      !validators.isHexadecimal(value) ? message : null;
}

class LyStringIsHexColor extends LyValidator<String> {
  LyStringIsHexColor(super.message);

  @override
  String? call(String value) => !validators.isHexColor(value) ? message : null;
}

class LyStringIsLowercase extends LyValidator<String> {
  LyStringIsLowercase(super.message);

  @override
  String? call(String value) => !validators.isLowercase(value) ? message : null;
}

class LyStringIsUppercase extends LyValidator<String> {
  LyStringIsUppercase(super.message);

  @override
  String? call(String value) => !validators.isUppercase(value) ? message : null;
}

// TODO: Finish implementation

// /// check if the String [value] is a number that's divisible by another
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

// /// check if the String [value] is null
// static InputValidator<String?> isNull({
//   required String message,
// }) {
//   return (value) => value != null ? message : null;
// }

// /// check if the length of the String [value] falls in a range
// static InputValidator<String?> isLength({
//   required String message,
//   required int min,
//   int? max,
// }) {
//   return (value) => !validators.isLength(value, min, max)
//       ? message
//       : null;
// }

// /// check if the String's length (in bytes) falls in a range.
// static InputValidator<String?> isByteLength({
//   required String message,
//   required int min,
//   int? max,
// }) {
//   return (value) => !validators.isByteLength(value, min, max)
//       ? message
//       : null;
// }

// /// check if the String is a UUID (version 3, 4 or 5).
// static InputValidator<String?> isUUID({
//   required String message,
//   dynamic version,
// }) {
//   return (value) => !validators.isUUID(value, version)
//       ? message
//       : null;
// }

// /// check if the String is a date
// static InputValidator<String?> isDate({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isDate(value) ? message : null;
// }

// /// check if the String is a date that's after the specified date
// ///
// /// If `date` is not passed, it defaults to now.
// static InputValidator<String?> isAfter({
//   required String message,
//   DateTime? date,
// }) {
//   return (value) =>
//       !validators.isAfter(value, date) ? message : null;
// }

// /// check if the String is a date that's before the specified date
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

// /// check if the String is in a array of allowed values
// static InputValidator<String?> isIn({
//   required String message,
//   required Iterable<String> values,
// }) {
//   return (value) =>
//       !(validators.isIn(value, values) ?? false)
//           ? message
//           : null;
// }

// /// check if the String is a credit card
// static InputValidator<String?> isCreditCard({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isCreditCard(value) ? message : null;
// }

// // /// check if the String is an ISBN (version 10 or 13)
// static InputValidator<String?> isISBN({
//   required String message,
//   dynamic version,
// }) {
//   return (value) => !validators.isISBN(value, version)
//       ? message
//       : null;
// }

// /// check if the String is valid JSON
// static InputValidator<String?> isJSON({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isJSON(value) ? message : null;
// }

// /// check if the String contains one or more multibyte chars
// static InputValidator<String?> isMultibyte({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isMultibyte(value) ? message : null;
// }

// /// check if the String contains ASCII chars only
// static InputValidator<String?> isAscii({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isAscii(value) ? message : null;
// }

// /// check if the String contains any full-width chars
// static InputValidator<String?> isFullWidth({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isFullWidth(value) ? message : null;
// }

// /// check if the String contains any half-width chars
// static InputValidator<String?> isHalfWidth({
//   required String message,
// }) {
//   return (value) =>
//       !validators.isHalfWidth(value) ? message : null;
// }

// /// check if the String contains a mixture of full and half-width chars
// static InputValidator<String?> isVariableWidth({
//   required String message,
// }) {
//   return (value) => !validators.isVariableWidth(value)
//       ? message
//       : null;
// }

// /// check if the String contains any surrogate pairs chars
// static InputValidator<String?> isSurrogatePair({
//   required String message,
// }) {
//   return (value) => !validators.isSurrogatePair(value)
//       ? message
//       : null;
// }

// /// check if the String is a valid hex-encoded representation of a MongoDB ObjectId
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
