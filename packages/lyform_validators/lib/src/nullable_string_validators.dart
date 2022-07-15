import 'package:lyform/lyform.dart';
import 'package:validators/validators.dart' as validators;

class LyNullableStringLengthGreaterThan extends LyValidator<String?> {
  LyNullableStringLengthGreaterThan(super.message, this.len);

  final int len;

  @override
  String? call(String? value) => value == null
      ? null
      : value.length > len
          ? null
          : message;
}

class LyNullableStringLengthLowerThan extends LyValidator<String?> {
  LyNullableStringLengthLowerThan(super.message, this.len);

  final int len;

  @override
  String? call(String? value) => value == null
      ? null
      : value.length < len
          ? null
          : message;
}

class LyNullableStringPasswordMatch extends LyValidator<String?> {
  LyNullableStringPasswordMatch(super.message, this.match);

  final String Function() match;

  @override
  String? call(String? value) => value == null
      ? null
      : value != match()
          ? message
          : null;
}

class LyNullableStringEquals extends LyValidator<String?> {
  LyNullableStringEquals(super.message, this.comparison);

  final dynamic comparison;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.equals(value, comparison)
          ? message
          : null;
}

class LyNullableStringContains extends LyValidator<String?> {
  LyNullableStringContains(super.message, this.seed);

  final dynamic seed;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.contains(value, seed)
          ? message
          : null;
}

class LyNullableStringMatches extends LyValidator<String?> {
  LyNullableStringMatches(super.message, this.pattern);

  final dynamic pattern;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.matches(value, pattern)
          ? message
          : null;
}

class LyNullableStringIsEmail extends LyValidator<String?> {
  LyNullableStringIsEmail(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isEmail(value)
          ? message
          : null;
}

class LyNullableStringIsURL extends LyValidator<String?> {
  LyNullableStringIsURL(
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

class LyNullableStringIsFQDN extends LyValidator<String?> {
  LyNullableStringIsFQDN(
    super.message, [
    this.requireTld = true,
    this.allowUnderscores = false,
  ]);

  final bool requireTld;
  final bool allowUnderscores;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isFQDN(value)
          ? message
          : null;
}

class LyNullableStringIsAlpha extends LyValidator<String?> {
  LyNullableStringIsAlpha(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isAlpha(value)
          ? message
          : null;
}

class LyNullableStringIsNumeric extends LyValidator<String?> {
  LyNullableStringIsNumeric(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isNumeric(value)
          ? message
          : null;
}

class LyNullableStringIsAlphanumeric extends LyValidator<String?> {
  LyNullableStringIsAlphanumeric(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isAlphanumeric(value)
          ? message
          : null;
}

class LyNullableStringIsBase64 extends LyValidator<String?> {
  LyNullableStringIsBase64(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isBase64(value)
          ? message
          : null;
}

class LyNullableStringIsInt extends LyValidator<String?> {
  LyNullableStringIsInt(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isInt(value)
          ? message
          : null;
}

class LyNullableStringIsFloat extends LyValidator<String?> {
  LyNullableStringIsFloat(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isFloat(value)
          ? message
          : null;
}

class LyNullableStringIsHexadecimal extends LyValidator<String?> {
  LyNullableStringIsHexadecimal(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isHexadecimal(value)
          ? message
          : null;
}

class LyNullableStringIsHexColor extends LyValidator<String?> {
  LyNullableStringIsHexColor(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isHexColor(value)
          ? message
          : null;
}

class LyNullableStringIsLowercase extends LyValidator<String?> {
  LyNullableStringIsLowercase(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isLowercase(value)
          ? message
          : null;
}

class LyNullableStringIsUppercase extends LyValidator<String?> {
  LyNullableStringIsUppercase(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isUppercase(value)
          ? message
          : null;
}
