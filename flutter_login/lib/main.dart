import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/app.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  runApp(MyApp(
    authenticationRepostiory: AuthenticationRepostiory(),
    userRepository: UserRepository(),
  ));
}
