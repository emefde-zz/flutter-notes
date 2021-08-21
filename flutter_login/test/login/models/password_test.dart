import 'package:flutter_login/login/login.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('test constructors', () {
    test('test pure password', () {
      final password = Password.pure();
      expect(password.value, '');
      expect(password.pure, true);
    });

    test('test dirty password', () {
      final password = Password.dirty('password');
      expect(password.value, 'password');
      expect(password.pure, false);
    });
  });

  group('valdiator tests', () {
    test('return empty error when password empty', () {
      expect(Password.dirty('').error, PasswordValidationError.empty);
    });

    test('no error when password not empty', () {
      expect(Password.dirty('password').error, null);
    });
  });
}
