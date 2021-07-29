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

    test('initial state is 0', () {
      expect(counterBloc.state, 0);
    });

    blocTest<CounterBloc, int>(
        'emits [1] when CounterEvent.increment is added',
        build: () => counterBloc,
        act: (bloc) => bloc.add(CounterEvent.increment),
        expect: () => [1]
    );

    blocTest<CounterBloc, int>(
        'emits [-1] when CounterEvent.decrement is added',
        build: () => counterBloc,
        act: (bloc) => bloc.add(CounterEvent.decrement),
        expect: () => [-1]
    );

  });

}