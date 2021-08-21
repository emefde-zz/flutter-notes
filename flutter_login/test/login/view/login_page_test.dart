import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_login/login/login.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepostiory {}

main() {
  late AuthenticationRepostiory authenticationRepostiory;

  setUp(() {
    authenticationRepostiory = MockAuthenticationRepository();
  });

  group('LoginPage tests', () {
    test('LoginPage is routable', () {
      expect(LoginPage.route(), isA<MaterialPageRoute>());
    });

    testWidgets(
      "identify LoginPage",
      (WidgetTester tester) async {
        await tester.pumpWidget(RepositoryProvider.value(
            value: authenticationRepostiory,
            child: MaterialApp(
              home: Scaffold(body: LoginPage()),
            )));
      },
    );
    expect(find.byType(LoginForm), findsOneWidget);
  });
}
