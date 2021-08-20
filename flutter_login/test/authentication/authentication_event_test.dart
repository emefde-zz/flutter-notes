import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_login/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationStatusChanged', () {
    test('supports value comparison', () {
      expect(AuthenticationStatusChanged(AuthenticationStatus.authenticated),
          AuthenticationStatusChanged(AuthenticationStatus.authenticated));
    });
  });

  group('LoggedOut', () {
    test('supports value comparison', () {
      expect(AuthenticationLogoutRequested(), AuthenticationLogoutRequested());
    });
  });
}
