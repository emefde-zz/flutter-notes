import 'package:flutter_login/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test LoginUsernameChanged', () {
    test('is equal with same username', () {
      expect(
          LoginUsernameChanged('username'), LoginUsernameChanged('username'));
    });

    test('is not equal with different username', () {
      expect(
          LoginUsernameChanged('username') != LoginUsernameChanged('othername'),
          true);
    });
  });

  group('Test LoginPasswordChanged', () {
    test('is equal with same username', () {
      expect(
          LoginPasswordChanged('password'), LoginPasswordChanged('password'));
    });

    test('is not equal with different passwords', () {
      expect(LoginPasswordChanged('psswrd') != LoginPasswordChanged('password'),
          true);
    });
  });

  group('Test LoginSubmitted', () {
    test('supports value comparison', () {
      expect(LoginSubmitted(), LoginSubmitted());
    });
  });
}
