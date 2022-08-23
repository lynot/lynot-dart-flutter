import 'package:lyform_validators/src/string_validators.dart';
import 'package:test/test.dart';

void main() {
  group('StringRequired', () {
    final validator = LyStringRequired('Name required');

    test('should return null if the value is not empty', () {
      expect(validator('Laura'), isNull);
    });

    test('should return the error message if the value is empty', () {
      expect(validator(''), equals('Name required'));
    });
  });

  group('StringLengthGreaterThan', () {
    final validator = LyStringLengthGreaterThan(
      'String length should be greater then 8',
      8,
    );

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

  group('StringLengthLowerThan', () {
    final validator =
        LyStringLengthLowerThan('String should be lower then 6', 6);

    test('should return null if the value length is not lower then 6', () {
      expect(validator('Hello'), isNull);
    });

    test('should return the error message if the value is empty', () {
      expect(
        validator('Hello World'),
        equals('String should be lower then 6'),
      );
    });
  });

  group('StringPasswordMatch', () {
    final validator = LyStringPasswordMatch('Invalid password', () => 'abc');
    test('should return null if the value matches passwords', () {
      expect(validator('abc'), isNull);
    });

    test(
        'should return the error message if the value does not match '
        'the password', () {
      expect(validator('abc123'), equals('Invalid password'));
    });
  });

  group('StringEquals', () {
    final validator = LyStringEquals('Invalid value', 'abc');
    test('should return null if the value is equal to the expected value', () {
      expect(validator('abc'), isNull);
    });

    test('should return the error message if the value is not equal', () {
      expect(validator('abc123'), equals('Invalid value'));
    });
  });

  group('StringContains', () {
    final validator = LyStringContains('Invalid value', 'abc');

    test(
        'should return null if the value contains the expected value '
        'in the seed', () {
      expect(validator('abc123'), isNull);
    });

    test(
        'should return the error message if the value is not contained in seed',
        () {
      expect(validator('123'), equals('Invalid value'));
    });
  });

  group('StringMatches', () {
    final validator = LyStringMatches('Invalid value', r'^[a-zA-Z0-9]*$');

    test('should return null if the value matches the regex', () {
      expect(validator('abc123'), isNull);
    });

    test(
        'should return the error message if the value does not match the regex',
        () {
      expect(validator('abc@123'), equals('Invalid value'));
    });
  });

  group('StringIsEmail', () {
    final validator = LyStringIsEmail('Invalid email');

    test('should return null if the value is a valid email', () {
      expect(validator('laura@gmail.com'), isNull);
    });

    test('should return an error message if the value is not a valid email',
        () {
      expect(validator('laura@gmail'), equals('Invalid email'));
    });
  });

  group('StringIsUrl', () {
    final validator = LyStringIsURL('Invalid url');

    test('should return null if the value is a valid url', () {
      expect(validator('https://www.google.com'), isNull);
    });

    test('should return an error message if the value is not a valid url', () {
      expect(validator('https:/www.google.com'), equals('Invalid url'));
    });
  });

  group('StringIsIP', () {
    final validator = LyStringIsIP('Invalid ip', '4');

    test('should return null if the value is a valid ip', () {
      expect(validator('192.168.100.1'), isNull);
    });

    test('should return an error message if the value is not a valid ip', () {
      expect(validator('192.100.1'), 'Invalid ip');
    });
  });

  group('StringIsFQDN', () {
    final validator = LyStringIsFQDN('Invalid fqdn');

    test('should return null if the value is a valid fqdn', () {
      expect(validator('www.google.com'), isNull);
    });

    test('should return an error message if the value is not a valid fqdn', () {
      expect(validator('google,com'), 'Invalid fqdn');
    });
  });

  group('StringIsAlpha', () {
    final validator = LyStringIsAlpha('Invalid alpha');

    test('should return null if the value is a valid alpha', () {
      expect(validator('abc'), isNull);
    });

    test('should return an error message if the value is not a valid alpha',
        () {
      expect(validator('abc123'), 'Invalid alpha');
    });
  });

  group('StringIsNumeric', () {
    final validator = LyStringIsNumeric('Invalid numeric');

    test('should return null if the value is a valid numeric', () {
      expect(validator('123'), isNull);
    });

    test('should return an error message if the value is not a valid numeric',
        () {
      expect(validator('abc123'), 'Invalid numeric');
    });
  });

  group('StringIsAlphaNumeric', () {
    final validator = LyStringIsAlphanumeric('Invalid alpha numeric');

    test('should return null if the value is a valid alpha numeric', () {
      expect(validator('abc123'), isNull);
    });

    test(
        'should return an error message if the value is not a valid alpha numeric',
        () {
      expect(validator('abc@123'), 'Invalid alpha numeric');
    });
  });

  group('StringIsBase64', () {
    final validator = LyStringIsBase64('Invalid base64');

    test('should return null if the value is a valid base64', () {
      expect(validator('YWJj'), isNull);
    });

    test('should return an error message if the value is not a valid base64',
        () {
      expect(validator('YWJj123'), 'Invalid base64');
    });
  });

  group('StringIsInt', () {
    final validator = LyStringIsInt('Invalid integer');

    test('should return null if the value is a valid integer', () {
      expect(validator('123'), isNull);
    });

    test('should return an error message if the value is not a valid integer',
        () {
      expect(validator('abc123'), 'Invalid integer');
    });
  });

  group('StringIsFloat', () {
    final validator = LyStringIsFloat('Invalid float');

    test('should return null if the value is a valid float', () {
      expect(validator('123.123'), isNull);
    });

    test('should return an error message if the value is not a valid float',
        () {
      expect(validator('abc123'), 'Invalid float');
    });
  });

  group('StringIsHexadecimal', () {
    final validator = LyStringIsHexadecimal('Invalid hexadecimal');
    test('should return null if the value is a valid hexadecimal', () {
      expect(validator('123abc'), isNull);
    });

    test(
        'should return an error message if the value is not a valid hexadecimal',
        () {
      expect(validator('W123'), 'Invalid hexadecimal');
    });
  });

  group('StringIsHexColor', () {
    final validator = LyStringIsHexColor('Invalid hex color');

    test('should return null if the value is a valid hex color', () {
      expect(validator('#123abc'), isNull);
    });

    test('should return an error message if the value is not a valid hex color',
        () {
      expect(validator('#W123'), 'Invalid hex color');
    });
  });

  group('StringIsLowercase', () {
    final validator = LyStringIsLowercase('Invalid lowercase');

    test('should return null if the value is a valid lowercase', () {
      expect(validator('abc'), isNull);
    });

    test('should return an error message if the value is not a valid lowercase',
        () {
      expect(validator('ABC'), 'Invalid lowercase');
    });
  });

  group('StringIsUppercase', () {
    final validator = LyStringIsUppercase('Invalid uppercase');

    test('should return null if the value is a valid uppercase', () {
      expect(validator('ABC'), isNull);
    });

    test('should return an error message if the value is not a valid uppercase',
        () {
      expect(validator('abc'), 'Invalid uppercase');
    });
  });
}
