import 'package:flutter_login/login/login.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('test constructors', () {
    test('test pure username', () {
      final username = Username.pure();
      expect(username.value, '');
      expect(username.pure, true);
    });

    test('test dirty username', () {
      final username = Username.dirty('username');
      expect(username.value, 'username');
      expect(username.pure, false);
    });
  });

  group('valdiator tests', () {
    test('return empty error when username empty', () {
      expect(Username.dirty('').error, UsernameValidationError.empty);
    });

    test('no error when username not empty', () {
      expect(Username.dirty('username').error, null);
    });
  });
}
