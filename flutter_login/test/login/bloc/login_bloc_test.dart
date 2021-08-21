import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_login/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationRepostiory])
main() {
  const user = User('123');
  late AuthenticationRepostiory authenticationRepostiory;

  setUp(() {
    authenticationRepostiory = MockAuthenticationRepostiory();
    when(authenticationRepostiory.status).thenAnswer((_) => Stream.empty());
  });

  group('test LoginBloc init', () {
    test('test initial state is correct', () {
      final bloc =
          LoginBloc(authenticationRepostiory: authenticationRepostiory);
      expect(bloc.state, LoginState());
    });
  });

  group('test LoginBloc states', () {
    final username = Username.dirty('username');
    blocTest<LoginBloc, LoginState>(
        'emits [LoginState.username] when LoginUsernameChanged is added.',
        build: () =>
            LoginBloc(authenticationRepostiory: authenticationRepostiory),
        act: (bloc) => bloc.add(LoginUsernameChanged(username.value)),
        expect: () => const <LoginState>[
              LoginState(
                  status: FormzStatus.invalid,
                  username: Username.dirty('username'))
            ],
        verify: (bloc) {
          expect(
              bloc.state,
              LoginState(
                  username: username,
                  status: Formz.validate([bloc.state.password, username])));
        });

    final password = Password.dirty('password');
    blocTest<LoginBloc, LoginState>(
        'emits [LoginState.password] when LoginPasswordChanged is added.',
        build: () =>
            LoginBloc(authenticationRepostiory: authenticationRepostiory),
        act: (bloc) => bloc.add(LoginPasswordChanged(password.value)),
        verify: (bloc) {
          expect(
              bloc.state,
              LoginState(
                  password: password,
                  status: Formz.validate([bloc.state.username, password])));
        });

    blocTest<LoginBloc, LoginState>(
        'emits [submissionSuccess] when LoginSubmitted is added.'
        'and state is [validated]',
        build: () {
          when(authenticationRepostiory.login(
                  username: 'username', password: 'password'))
              .thenAnswer((_) => Future.value());
          return LoginBloc(authenticationRepostiory: authenticationRepostiory);
        },
        act: (bloc) {
          bloc
            ..add(LoginUsernameChanged('username'))
            ..add(LoginPasswordChanged('password'))
            ..add(LoginSubmitted());
        },
        expect: () => const <LoginState>[
              LoginState(
                  status: FormzStatus.invalid,
                  username: Username.dirty('username')),
              LoginState(
                  status: FormzStatus.valid,
                  username: Username.dirty('username'),
                  password: Password.dirty('password')),
              LoginState(
                  status: FormzStatus.submissionInProgress,
                  username: Username.dirty('username'),
                  password: Password.dirty('password')),
              LoginState(
                  status: FormzStatus.submissionSuccess,
                  username: Username.dirty('username'),
                  password: Password.dirty('password'))
            ],
        verify: (bloc) {
          expect(bloc.state.status, FormzStatus.submissionSuccess);
        });

    blocTest<LoginBloc, LoginState>(
        'emits [submissionFailure] when LoginSubmitted is added.'
        'but login throws', build: () {
      when(authenticationRepostiory.login(
              username: 'username', password: 'password'))
          .thenThrow(Exception('whoops'));
      return LoginBloc(authenticationRepostiory: authenticationRepostiory);
    }, act: (bloc) {
      bloc
        ..add(LoginUsernameChanged('username'))
        ..add(LoginPasswordChanged('password'))
        ..add(LoginSubmitted());
    }, verify: (bloc) {
      expect(bloc.state.status, FormzStatus.submissionFailure);
    });
  });
}
