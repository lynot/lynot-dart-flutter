import 'package:lyform/lyform.dart';
import 'package:validators/validators.dart' as validators;

class NullableStringLengthGreaterThan extends Validator<String?> {
  NullableStringLengthGreaterThan(super.message, this.len);

  final int len;

  @override
  String? call(String? value) => value == null
      ? null
      : value.length > len
          ? null
          : message;
}

class NullableStringLengthLowerThan extends Validator<String?> {
  NullableStringLengthLowerThan(super.message, this.len);

  final int len;

  @override
  String? call(String? value) => value == null
      ? null
      : value.length < len
          ? null
          : message;
}

class NullableStringPasswordMatch extends Validator<String?> {
  NullableStringPasswordMatch(super.message, this.match);

  final String Function() match;

  @override
  String? call(String? value) => value == null
      ? null
      : value != match()
          ? message
          : null;
}

class NullableStringEquals extends Validator<String?> {
  NullableStringEquals(super.message, this.comparison);

  final dynamic comparison;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.equals(value, comparison)
          ? message
          : null;
}

class NullableStringContains extends Validator<String?> {
  NullableStringContains(super.message, this.seed);

  final dynamic seed;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.contains(value, seed)
          ? message
          : null;
}

class NullableStringMatches extends Validator<String?> {
  NullableStringMatches(super.message, this.pattern);

  final dynamic pattern;

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.matches(value, pattern)
          ? message
          : null;
}

class NullableStringIsEmail extends Validator<String?> {
  NullableStringIsEmail(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isEmail(value)
          ? message
          : null;
}

class NullableStringIsURL extends Validator<String?> {
  NullableStringIsURL(
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

class NullableStringIsIP extends Validator<String?> {
  NullableStringIsIP(super.message, this.version);

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

class NullableStringIsAlpha extends Validator<String?> {
  NullableStringIsAlpha(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isAlpha(value)
          ? message
          : null;
}

class NullableStringIsNumeric extends Validator<String?> {
  NullableStringIsNumeric(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isNumeric(value)
          ? message
          : null;
}

class NullableStringIsAlphanumeric extends Validator<String?> {
  NullableStringIsAlphanumeric(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isAlphanumeric(value)
          ? message
          : null;
}

class NullableStringIsBase64 extends Validator<String?> {
  NullableStringIsBase64(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isBase64(value)
          ? message
          : null;
}

class NullableStringIsInt extends Validator<String?> {
  NullableStringIsInt(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isInt(value)
          ? message
          : null;
}

class NullableStringIsFloat extends Validator<String?> {
  NullableStringIsFloat(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isFloat(value)
          ? message
          : null;
}

class NullableStringIsHexadecimal extends Validator<String?> {
  NullableStringIsHexadecimal(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isHexadecimal(value)
          ? message
          : null;
}

class NullableStringIsHexColor extends Validator<String?> {
  NullableStringIsHexColor(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isHexColor(value)
          ? message
          : null;
}

class NullableStringIsLowercase extends Validator<String?> {
  NullableStringIsLowercase(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isLowercase(value)
          ? message
          : null;
}

class NullableStringIsUppercase extends Validator<String?> {
  NullableStringIsUppercase(super.message);

  @override
  String? call(String? value) => value == null
      ? null
      : !validators.isUppercase(value)
          ? message
          : null;
}
