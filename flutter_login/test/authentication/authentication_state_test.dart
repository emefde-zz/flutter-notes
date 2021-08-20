import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements User {}

void main() {
  group('AuthenticationState.unauthenticated', () {
    test('supports value comparison', () {
      expect(AuthenticationState.unauthenticated(),
          AuthenticationState.unauthenticated());
    });
  });

  group('AuthenticationState.authenticated', () {
    final user = MockUser();
    test('supports value comparison', () {
      expect(AuthenticationState.authenticated(user),
          AuthenticationState.authenticated(user));
    });
  });

  group('AuthenticationState.unknown', () {
    test('supports value comparison', () {
      expect(AuthenticationState.unknown(), AuthenticationState.unknown());
    });
  });
}
