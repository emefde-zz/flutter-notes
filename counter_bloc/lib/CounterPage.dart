import 'package:counter_bloc/CounterBloc.dart';
import 'package:counter_bloc/CounterView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterPage extends StatelessWidget {

  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: CounterView()
    );
  }
}

