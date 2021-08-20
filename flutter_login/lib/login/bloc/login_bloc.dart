import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/login/login.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepostiory authenticationRepostiory})
      : _authenticationRepostiory = authenticationRepostiory,
        super(const LoginState());

  final AuthenticationRepostiory _authenticationRepostiory;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapLoginUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapLoginPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedoState(event, state);
    }
  }

  LoginState _mapLoginUsernameChangedToState(
      LoginUsernameChanged event, LoginState state) {
    final username = Username.dirt(event.username);
    return state.copyWith(
        username: username, status: Formz.validate([state.password, username]));
  }

  LoginState _mapLoginPasswordChangedToState(
      LoginPasswordChanged event, LoginState state) {
    final password = Password.dirty(event.password);
    return state.copyWith(
        password: password, status: Formz.validate([password, state.username]));
  }

  Stream<LoginState> _mapLoginSubmittedoState(
      LoginSubmitted event, LoginState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepostiory.login(
            username: state.username.value, password: state.password.value);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
