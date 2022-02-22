import 'package:lyform/lyform.dart';
import 'package:validators/validators.dart' as validators;

class NullableStringLengthGreaterThan extends Validator<String?> {
  NullableStringLengthGreaterThan(String message, this.len) : super(message);

  final int len;

  @override
  String? call(String? value) => value == null
      ? null
      : value.length > len
          ? null
          : message;
}

class NullableStringLengthLowerThan extends Validator<String?> {
  NullableStringLengthLowerThan(String message, this.len) : super(message);

  final int len;

  @override
  String? call(String? value) => value == null
      ? null
      : value.length < len
          ? null
          : message;
}

class NullableStringPasswordMatch extends Validator<String?> {
  NullableStringPasswordMatch(String message, this.match) : super(message);

  final String Function() match;

  @override
  String? call(String? value) => value == null
      ? null
      : value != match()
          ? message
          : null;
}

class NullableStringEquals extends Validator<String?> {
  NullableStringEquals(String message, this.comparison) : super(message);

  final dynamic comparison;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.equals(value, comparison)
          ? message
          : null;
}

class NullableStringContains extends Validator<String?> {
  NullableStringContains(String message, this.seed) : super(message);

  final dynamic seed;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.contains(value, seed)
          ? message
          : null;
}

class NullableStringMatches extends Validator<String?> {
  NullableStringMatches(String message, this.pattern) : super(message);

  final dynamic pattern;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.matches(value, pattern)
          ? message
          : null;
}

class NullableStringIsEmail extends Validator<String?> {
  NullableStringIsEmail(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isEmail(value)
          ? message
          : null;
}

class NullableStringIsURL extends Validator<String?> {
  NullableStringIsURL(
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

class NullableStringIsIP extends Validator<String?> {
  NullableStringIsIP(String message, this.version) : super(message);

  final dynamic version;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isIP(value, version)
          ? message
          : null;
}

class NullableStringIsFQDN extends Validator<String?> {
  NullableStringIsFQDN(
    String message, [
    this.requireTld = true,
    this.allowUnderscores = false,
  ]) : super(message);

  final bool requireTld;
  final bool allowUnderscores;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isFQDN(value)
          ? message
          : null;
}

class NullableStringIsAlpha extends Validator<String?> {
  NullableStringIsAlpha(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isAlpha(value)
          ? message
          : null;
}

class NullableStringIsNumeric extends Validator<String?> {
  NullableStringIsNumeric(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isNumeric(value)
          ? message
          : null;
}

class NullableStringIsAlphanumeric extends Validator<String?> {
  NullableStringIsAlphanumeric(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isAlphanumeric(value)
          ? message
          : null;
}

class NullableStringIsBase64 extends Validator<String?> {
  NullableStringIsBase64(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isBase64(value)
          ? message
          : null;
}

class NullableStringIsInt extends Validator<String?> {
  NullableStringIsInt(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isInt(value)
          ? message
          : null;
}

class NullableStringIsFloat extends Validator<String?> {
  NullableStringIsFloat(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isFloat(value)
          ? message
          : null;
}

class NullableStringIsHexadecimal extends Validator<String?> {
  NullableStringIsHexadecimal(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isHexadecimal(value)
          ? message
          : null;
}

class NullableStringIsHexColor extends Validator<String?> {
  NullableStringIsHexColor(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isHexColor(value)
          ? message
          : null;
}

class NullableStringIsLowercase extends Validator<String?> {
  NullableStringIsLowercase(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isLowercase(value)
          ? message
          : null;
}

class NullableStringIsUppercase extends Validator<String?> {
  NullableStringIsUppercase(String message) : super(message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isUppercase(value)
          ? message
          : null;
}
