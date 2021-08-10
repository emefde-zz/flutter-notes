part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.user = User.empty, this.status = AuthenticationStatus.unknown});

  const AuthenticationState.unknown() : this._();
  const AuthenticationState.authenticated(User user)
      : this._(user: user, status: AuthenticationStatus.authenticated);
  const AuthenticationState.unauthenticated(User user)
      : this._(user: user, status: AuthenticationStatus.unauthenticated);

  final User user;
  final AuthenticationStatus status;

  @override
  List<Object> get props => [user, status];
}
