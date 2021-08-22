import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_login/login/login.dart';
import 'package:formz/formz.dart';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'login_form_test.mocks.dart';

@GenerateMocks([LoginBloc])
main() {
  group('LoginForm tests', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = MockLoginBloc();
      when(loginBloc.stream).thenAnswer((_) => Stream.empty());
    });

    testWidgets(
      'adds LoginUsernameChanged to LoginBloc when username is updated',
      (WidgetTester tester) async {
        const username = 'username';
        when(loginBloc.state).thenReturn(const LoginState());
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: LoginForm(),
            ),
          ),
        ));
        await tester.enterText(
            find.byKey(const Key('loginForm_usernameInput_textField')),
            username);
        verify(loginBloc.add(LoginUsernameChanged(username))).called(1);
      },
    );

    testWidgets(
      "adds LoginPasswordChanged to LoginBloc when password is updated",
      (WidgetTester tester) async {
        const password = 'password';
        when(loginBloc.state).thenReturn(const LoginState());
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: LoginForm(),
            ),
          ),
        ));
        await tester.enterText(
            find.byKey(const Key('loginForm_passwordInput_textField')),
            password);
        verify(loginBloc.add(LoginPasswordChanged(password))).called(1);
      },
    );

    testWidgets(
      "CircularProgressIndicator when status is [isSubmissionInProgress]",
      (WidgetTester tester) async {
        when(loginBloc.state)
            .thenReturn(LoginState(status: FormzStatus.submissionInProgress));
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: LoginForm(),
            ),
          ),
        ));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'adds LoginSubmitted to LoginBloc when [username]'
      'and [password] are validated',
      (WidgetTester tester) async {
        const username = Username.dirty('username');
        const password = Password.dirty('password');
        when(loginBloc.state).thenReturn(LoginState(
            username: username, password: password, status: FormzStatus.valid));
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: LoginForm(),
            ),
          ),
        ));
        await tester
            .tap(find.byKey(const Key('loginForm_continue_raisedButton')));
        verify(loginBloc.add(LoginSubmitted())).called(1);
      },
    );

    testWidgets(
      'test LoginButton disabled by default',
      (WidgetTester tester) async {
        when(loginBloc.state).thenReturn(LoginState());
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: LoginForm(),
            ),
          ),
        ));
        final button = tester.widget<ElevatedButton>(
            find.byKey(const Key('loginForm_continue_raisedButton')));
        expect(button.enabled, false);
      },
    );

    testWidgets(
      'test LoginButton enabled with proper values',
      (WidgetTester tester) async {
        const username = Username.dirty('username');
        const password = Password.dirty('password');
        when(loginBloc.state).thenReturn(LoginState(
            username: username, password: password, status: FormzStatus.valid));
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: LoginForm(),
            ),
          ),
        ));
        final button = tester.widget<ElevatedButton>(
            find.byKey(const Key('loginForm_continue_raisedButton')));
        expect(button.enabled, true);
      },
    );
  });
}
