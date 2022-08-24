import 'package:lyform_validators/lyform_validators.dart';
import 'package:test/test.dart';

void main() {
  group('LyNullableStringLengthGreaterThan', () {
    final validator = LyNullableStringLengthGreaterThan(
      'String length should be greater then 8',
      8,
    );

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is not greater then 8', () {
      expect(validator('Hello World'), isNull);
    });

    test('should return the error message if the value greater then 8', () {
      expect(
        validator('Hello'),
        equals('String length should be greater then 8'),
      );
    });
  });

  group('LyNullableStringLengthLowerThan', () {
    final validator = LyNullableStringLengthLowerThan(
      'String length should be lower then 8',
      8,
    );
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return an error message if the value is not lower then 8', () {
      expect(
        validator('Hello World'),
        equals('String length should be lower then 8'),
      );
    });

    test('should return null if the value is lower then 8', () {
      expect(validator('Hello'), isNull);
    });
  });

  group('LyNullableStringPasswordMatch', () {
    final validator =
        LyNullableStringPasswordMatch('Invalid password', () => 'abc');

    test('should return null if the value matches passwords', () {
      expect(validator('abc'), isNull);
    });

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test(
        'should return an error message if the value does not match the password',
        () {
      expect(validator('abc123'), equals('Invalid password'));
    });
  });

  group('LyNullableStringEquals', () {
    final validator = LyNullableStringEquals('Invalid value', 'abc');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is equal to the expected value', () {
      expect(validator('abc'), isNull);
    });

    test('should return an error message if the value is not equal', () {
      expect(validator('abc123'), equals('Invalid value'));
    });
  });

  group('LyNullableStringContains', () {
    final validator = LyNullableStringContains('Invalid value', 'abc');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });
    test(
        'should return null if the value contains the expected value in the seed',
        () {
      expect(validator('abc123'), isNull);
    });

    test(
        'should return an error message if the value is not contained in the seed',
        () {
      expect(validator('123'), equals('Invalid value'));
    });
  });

  group('LyNullableStringMatches', () {
    final validator =
        LyNullableStringMatches('Invalid value', r'^[a-zA-Z0-9]*$');

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value matches the regex', () {
      expect(validator('abc123'), isNull);
    });

    test('should return an error message if the value does not match the regex',
        () {
      expect(validator('abc@123'), equals('Invalid value'));
    });
  });

  group('LyNullableStringIsEmail', () {
    final validator = LyNullableStringIsEmail('Invalid email');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid email', () {
      expect(validator('laura@gmail.com'), isNull);
    });

    test('should return an error message if the value is not an email', () {
      expect(validator('laura@gmail'), equals('Invalid email'));
    });
  });

  group('LyNullableStringIsURL', () {
    final validator = LyNullableStringIsURL('Invalid url');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid url', () {
      expect(validator('https://www.google.com'), isNull);
    });

    test('should return an error message if the value is not an url', () {
      expect(validator('https:/www.google.com'), equals('Invalid url'));
    });
  });

  group('LyNullableStringIsIP', () {
    final validator = LyNullableStringIsIP('Invalid ip', '4');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid ip', () {
      expect(validator('192.168.100.1'), isNull);
    });

    test('should return an error message if the value is not a valid ip', () {
      expect(validator('192.100.1'), equals('Invalid ip'));
    });
  });

  group('LyNullableStringIsFQDN', () {
    final validator = LyNullableStringIsFQDN('Invalid fqdn');

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid fqdn', () {
      expect(validator('www.google.com'), isNull);
    });

    test('should return an error message if the value is not a valid fqdn', () {
      expect(validator('google,com'), equals('Invalid fqdn'));
    });
  });

  group('LyNullableStringIsAlpha', () {
    final validator = LyNullableStringIsAlpha('Invalid alpha');

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid alpha', () {
      expect(validator('abc'), isNull);
    });

    test('should return an error message if the value is not a valid alpha',
        () {
      expect(validator('abc123'), equals('Invalid alpha'));
    });
  });

  group('LyNullableStringIsNumeric', () {
    final validator = LyNullableStringIsNumeric('Invalid numeric');

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid numeric', () {
      expect(validator('123'), isNull);
    });

    test('should return an error message if the value is not a valid numeric',
        () {
      expect(validator('abc123'), equals('Invalid numeric'));
    });
  });

  group('LyNullableStringIsAlphanumeric', () {
    final validator = LyNullableStringIsAlphanumeric('Invalid alpha numeric');

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid alpha numeric', () {
      expect(validator('abc123'), isNull);
    });

    test(
        'should return an error message if the value is not a valid alpha numeric',
        () {
      expect(validator('abc@123'), equals('Invalid alpha numeric'));
    });
  });

  group('LyNullableStringIsBase64', () {
    final validator = LyNullableStringIsBase64('Invalid base64');

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });
    test('should return null if the value is a valid base64', () {
      expect(validator('YWJjMTIz'), isNull);
    });
    test('should return an error message if the value is not a valid base64',
        () {
      expect(validator('YWJjMTIzQ=='), equals('Invalid base64'));
    });
  });

  group('LyNullableStringIsInt', () {
    final validator = LyNullableStringIsInt('Invalid integer');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });
    test('should return null if the value is a valid integer', () {
      expect(validator('123'), isNull);
    });
    test('should return an error message if the value is not a valid integer',
        () {
      expect(validator('abc123'), equals('Invalid integer'));
    });
  });

  group('LyNullableStringIsFloat', () {
    final validator = LyNullableStringIsFloat('Invalid float');

    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid float', () {
      expect(validator('123.123'), isNull);
    });

    test('should return an error message if the value is not a valid float',
        () {
      expect(validator('H1A01'), equals('Invalid float'));
    });
  });

  group('LyNullableStringIsHexadecimal', () {
    final validator = LyNullableStringIsHexadecimal('Invalid hexadecimal');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid hexadecimal', () {
      expect(validator('123abc'), isNull);
    });

    test(
        'should return an error message if the value is not a valid hexadecimal',
        () {
      expect(validator('H1A01'), equals('Invalid hexadecimal'));
    });
  });

  group('LyNullableStringIsHexColor', () {
    final validator = LyNullableStringIsHexColor('Invalid hex color');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid hex color', () {
      expect(validator('#123abc'), isNull);
    });
    test('should return an error message if the value is not a valid hex color',
        () {
      expect(validator('#5'), equals('Invalid hex color'));
    });
  });

  group('LyNullableStringIsLowercase', () {
    final validator = LyNullableStringIsLowercase('Invalid lowercase');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid lowercase', () {
      expect(validator('abc'), isNull);
    });

    test('should return an error message if the value is not a valid lowercase',
        () {
      expect(validator('ABC'), equals('Invalid lowercase'));
    });
  });

  group('LyNullableStringIsUppercase', () {
    final validator = LyNullableStringIsUppercase('Invalid uppercase');
    test('should return null if the value is null', () {
      expect(validator(null), isNull);
    });

    test('should return null if the value is a valid uppercase', () {
      expect(validator('ABC'), isNull);
    });
    test('should return an error message if the value is not a valid uppercase',
        () {
      expect(validator('abc'), equals('Invalid uppercase'));
    });
  });
}
