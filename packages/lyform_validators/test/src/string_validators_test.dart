import 'package:lyform_validators/src/string_validators.dart';
import 'package:test/test.dart';

void main() {
  group('Sctring Validators', () {
    group('StringRequired', () {
      test('should return null if the value is not empty', () {
        final validator = LyStringRequired('Name required');
        expect(validator('Laura'), isNull);
      });

      test('should return the error message if the value is empty', () {
        final validator = LyStringRequired('Name required');
        expect(validator(''), 'Name required');
      });
    });

    group('StringLengthGreaterThan', () {
      test('should return null if the value is not greater then 8', () {
        final validator = LyStringLengthGreaterThan(
          'String length should be greater then 8',
          8,
        );
        expect(validator('Hello World'), isNull);
      });

      test('should return the error message if the value greater then 8', () {
        final validator = LyStringLengthGreaterThan(
          'String length should be greater then 8',
          8,
        );
        expect(validator('Hello'), 'String length should be greater then 8');
      });
    });

    group('StringLengthLowerThan', () {
      test('should return null if the value length is not lower then 6', () {
        final validator =
            LyStringLengthLowerThan('String should be lower then 6', 6);
        expect(validator('Hello'), isNull);
      });

      test('should return the error message if the value is empty', () {
        final validator =
            LyStringLengthLowerThan('String should be lower then 6', 6);
        expect(validator('Hello World'), 'String should be lower then 6');
      });
    });

    group('StringPasswordMatch', () {
      test('should return null if the value matches passwords', () {
        final validator =
            LyStringPasswordMatch('Invalid password', () => 'abc');
        expect(validator('abc'), isNull);
      });

      test(
          'should return the error message if the value '
          'does not match the password', () {
        final validator = LyStringPasswordMatch('Invalid password', () {
          return '';
        });
        expect(validator('abc123'), 'Invalid password');
      });
    });

    group('StringEquals', () {
      test('should return null if the value is equal to the expected value',
          () {
        final validator = LyStringEquals('Invalid value', 'abc');
        expect(validator('abc'), isNull);
      });

      test('should return the error message if the value is not equal', () {
        final validator = LyStringEquals('Invalid value', 'abc');
        expect(validator('abc123'), 'Invalid value');
      });
    });

    group('StringContains', () {
      test(
          'should return null if the value contains the expected value in the seed',
          () {
        final validator = LyStringContains('Invalid value', 'abc');
        expect(validator('abc123'), isNull);
      });

      test('should return the error message if the value is contained in seed',
          () {
        final validator = LyStringContains('Invalid value', '123');
        expect(validator('abc'), 'Invalid value');
      });
    });

    group('StringMatches', () {
      test('should return null if the value matches the regex', () {
        final validator = LyStringMatches('Invalid value', r'^[a-zA-Z0-9]*$');
        expect(validator('abc123'), isNull);
      });

      test(
          'should return the error message if the value does not match the regex',
          () {
        final validator = LyStringMatches('Invalid value', r'^[a-zA-Z0-9]*$');
        expect(validator('abc@123'), 'Invalid value');
      });
    });

    group('StringIsEmail', () {
      test('should return null if the value is a valid email', () {
        final validator = LyStringIsEmail('Invalid email');
        expect(validator('laura@gmail.com'), isNull);
      });

      test('should return null if the value is not a valid email', () {
        final validator = LyStringIsEmail('Invalid email');
        expect(validator('laura@gmail'), 'Invalid email');
      });
    });

    group('StringIsUrl', () {
      test('should return null if the value is a valid url', () {
        final validator = LyStringIsURL('Invalid url');
        expect(validator('https://www.google.com'), isNull);
      });

      test('should return null if the value is not a valid url', () {
        final validator = LyStringIsURL('Invalid url');
        expect(validator('https:/www.google.com'), 'Invalid url');
      });
    });

    group('StringIsIP', () {
      test('should return null if the value is a valid ip', () {
        final validator = LyStringIsIP('Invalid ip', '4');
        expect(validator('192.168.100.1'), isNull);
      });

      test('should return null if the value is not a valid ip', () {
        final validator = LyStringIsIP('Invalid ip', '4');
        expect(validator('192.100.1'), 'Invalid ip');
      });
    });

    group('StringIsFQDN', () {
      test('should return null if the value is a valid fqdn', () {
        final validator = LyStringIsFQDN('Invalid fqdn');
        expect(validator('www.google.com'), isNull);
      });

      test('should return null if the value is not a valid fqdn', () {
        final validator = LyStringIsFQDN('Invalid fqdn');
        expect(validator('google,com'), 'Invalid fqdn');
      });
    });

    group('StringIsAlpha', () {
      test('should return null if the value is a valid alpha', () {
        final validator = LyStringIsAlpha('Invalid alpha');
        expect(validator('abc'), isNull);
      });

      test('should return null if the value is not a valid alpha', () {
        final validator = LyStringIsAlpha('Invalid alpha');
        expect(validator('abc123'), 'Invalid alpha');
      });
    });

    group('StringIsNumeric', () {
      test('should return null if the value is a valid numeric', () {
        final validator = LyStringIsNumeric('Invalid numeric');
        expect(validator('123'), isNull);
      });

      test('should return null if the value is not a valid numeric', () {
        final validator = LyStringIsNumeric('Invalid numeric');
        expect(validator('abc123'), 'Invalid numeric');
      });
    });

    group('StringIsAlphaNumeric', () {
      test('should return null if the value is a valid alpha numeric', () {
        final validator = LyStringIsAlphanumeric('Invalid alpha numeric');
        expect(validator('abc123'), isNull);
      });

      test('should return null if the value is not a valid alpha numeric', () {
        final validator = LyStringIsAlphanumeric('Invalid alpha numeric');
        expect(validator('abc@123'), 'Invalid alpha numeric');
      });
    });

    group('StringIsBase64', () {
      test('should return null if the value is a valid base64', () {
        final validator = LyStringIsBase64('Invalid base64');
        expect(validator('YWJj'), isNull);
      });

      test('should return null if the value is not a valid base64', () {
        final validator = LyStringIsBase64('Invalid base64');
        expect(validator('YWJj123'), 'Invalid base64');
      });
    });

    group('StringIsInt', () {
      test('should return null if the value is a valid int', () {
        final validator = LyStringIsInt('Invalid int');
        expect(validator('123'), isNull);
      });

      test('should return null if the value is not a valid int', () {
        final validator = LyStringIsInt('Invalid int');
        expect(validator('abc123'), 'Invalid int');
      });
    });

    group('StringIsFloat', () {
      test('should return null if the value is a valid float', () {
        final validator = LyStringIsFloat('Invalid float');
        expect(validator('123.123'), isNull);
      });

      test('should return null if the value is not a valid float', () {
        final validator = LyStringIsFloat('Invalid float');
        expect(validator('abc123'), 'Invalid float');
      });
    });

    group('StringIsHexadecimal', () {
      test('should return null if the value is a valid hexadecimal', () {
        final validator = LyStringIsHexadecimal('Invalid hexadecimal');
        expect(validator('123abc'), isNull);
      });

      test('should return null if the value is not a valid hexadecimal', () {
        final validator = LyStringIsHexadecimal('Invalid hexadecimal');
        expect(validator('W123'), 'Invalid hexadecimal');
      });
    });

    group('StringIsHexColor', () {
      test('should return null if the value is a valid hex color', () {
        final validator = LyStringIsHexColor('Invalid hex color');
        expect(validator('#123abc'), isNull);
      });

      test('should return null if the value is not a valid hex color', () {
        final validator = LyStringIsHexColor('Invalid hex color');
        expect(validator('#W123'), 'Invalid hex color');
      });
    });

    group('StringIsLowercase', () {
      test('should return null if the value is a valid lowercase', () {
        final validator = LyStringIsLowercase('Invalid lowercase');
        expect(validator('abc'), isNull);
      });

      test('should return null if the value is not a valid lowercase', () {
        final validator = LyStringIsLowercase('Invalid lowercase');
        expect(validator('ABC'), 'Invalid lowercase');
      });
    });

    group('StringIsUppercase', () {
      test('should return null if the value is a valid uppercase', () {
        final validator = LyStringIsUppercase('Invalid uppercase');
        expect(validator('ABC'), isNull);
      });

      test('should return null if the value is not a valid uppercase', () {
        final validator = LyStringIsUppercase('Invalid uppercase');
        expect(validator('abc'), 'Invalid uppercase');
      });
    });
  });
}
