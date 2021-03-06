import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepostiory {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login(
      {required String username, required String password}) async {
    await Future<void>.delayed(const Duration(microseconds: 300),
        () => _controller.add(AuthenticationStatus.authenticated));
  }

  void logout() => _controller.add(AuthenticationStatus.unauthenticated);
  void dispose() => _controller.close();
}
