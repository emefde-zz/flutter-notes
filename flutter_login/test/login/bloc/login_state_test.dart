import 'package:flutter_login/login/bloc/login_bloc.dart';
import 'package:flutter_login/login/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

main() {
  group('test LoginState', () {
    test('supports value comparison', () {
      expect(LoginState(), LoginState());
    });

    test('has proper values set', () {
      final state = LoginState();
      expect(state.status, FormzStatus.pure);
      expect(state.password, Password.pure());
      expect(state.username, Username.pure());
    });

    test('returns same object when no properties are passed', () {
      expect(LoginState().copyWith(), LoginState());
    });
  });
}
