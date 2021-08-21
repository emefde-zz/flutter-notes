import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_login/login/login.dart';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

class FakeLoginEvent extends Fake implements LoginEvent {}

class FakeLoginState extends Fake implements LoginState {}

@GenerateMocks([LoginBloc])
main() {}
