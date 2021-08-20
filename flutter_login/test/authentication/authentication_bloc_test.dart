import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication_state_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepostiory {}

main(List<String> args) {
  const user = User('1');
  late AuthenticationRepostiory authenticationRepostiory;
  late UserRepository userRepository;

  setUp(() {
    authenticationRepostiory = MockAuthenticationRepository();
    when(() => authenticationRepostiory.status)
        .thenAnswer((_) => () => Stream.empty());
    userRepository = MockUserRepository();
  });

  group('AuthenticationBloc', () {
    test('initial state is AuthenticationState.unknown', () {
      final authenticationBloc = AuthenticationBloc(
          authenticationRepostiory: authenticationRepostiory,
          userRepository: userRepository);
      expect(authenticationBloc.state, AuthenticationState.unknown());
      authenticationBloc.close();
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [unauthenticated] when status is unauthenticated.',
        build: () {
          when(() => authenticationRepostiory.status).thenAnswer(
              (_) => () => Stream.value(AuthenticationStatus.unauthenticated));
          return AuthenticationBloc(
              authenticationRepostiory: authenticationRepostiory,
              userRepository: userRepository);
        },
        act: (bloc) => bloc.add(
            AuthenticationStatusChanged(AuthenticationStatus.unauthenticated)),
        expect: () =>
            const <AuthenticationState>[AuthenticationState.unauthenticated()]);

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when status is authenticated.',
      build: () {
        when(() => authenticationRepostiory.status).thenAnswer(
            (_) => () => Stream.value(AuthenticationStatus.authenticated));
        when(() => userRepository.getUser())
            .thenAnswer((_) => () async => user);
        return AuthenticationBloc(
            authenticationRepostiory: authenticationRepostiory,
            userRepository: userRepository);
      },
      act: (bloc) => bloc
          .add(AuthenticationStatusChanged(AuthenticationStatus.authenticated)),
      expect: () =>
          const <AuthenticationState>[AuthenticationState.authenticated(user)],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when MyEvent is added.',
      build: () => SubjectBloc(),
      act: (bloc) => bloc.add(MyEvent),
      expect: () => const <SubjectState>[MyState],
    );
  });
}
