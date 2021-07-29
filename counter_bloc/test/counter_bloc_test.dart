import 'package:counter_bloc/counter_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';


void main() {
  // {counter bloc tests}
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    // test initial state is 0
    test('initial state is 0', () {
      expect(counterBloc.state, 0);
    });

  });

}