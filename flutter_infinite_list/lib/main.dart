import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/app.dart';
import 'package:flutter_infinite_list/simple_bloc_observer.dart';
import 'package:bloc/bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}
