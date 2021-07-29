import 'package:bloc/bloc.dart';

// void main(List<String> arguments) async {
//   Stream<int> stream = intStream(10);
//   int sum = await sumStream(stream);

//   print(sum);
// }

void helloWorld() {
  print('Hello World');
}

Stream<int> intStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i;
  }
}

Future<int> sumStream(Stream<int> stream) async {
  int sum = 0;
  await for (int values in stream) {
    sum += values;
  }
  return sum;
}

class CounterCubit extends Cubit<int> {
  CounterCubit(int initialState) : super(initialState);

  void increment() => emit(state + 1);

  @override
  void onChange(Change<int> change) {
    print(change);
    super.onChange(change);
  }
}

final cubitA = CounterCubit(0); // zero state cubit
final cubitB = CounterCubit(10); // 10 state cubit

// void main() {
//   final cubit = CounterCubit(5);
//   print(cubit.state);
//   cubit.increment();
//   print(cubit.state);
//   cubit.close();
// }

// Future<void> main() async {
//   final cubid = CounterCubit(0);
//   final subscription = cubid.stream.listen(print);
//   cubid.increment();
//   await Future.delayed(Duration.zero);
//   cubid.increment();
//   await Future.delayed(Duration.zero);
//   await subscription.cancel();
//   await cubid.close();
// }

void main(List<String> args) {
  CounterCubit(0)
    ..increment()
    ..close();
}
