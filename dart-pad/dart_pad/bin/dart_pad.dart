import 'dart:math';
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

  void increment() {
    addError(Exception('increment error!'), StackTrace.current);
    emit(state + 1);
  }

  @override
  void onChange(Change<int> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
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

// void main(List<String> args) {
//   CounterCubit(0)
//     ..increment()
//     ..close();
// }

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }
}

// void main(List<String> args) {
//   Bloc.observer = SimpleBlocObserver();
//   CounterCubit(0)
//     ..increment()
//     ..close();

//   CounterCubit(5)
//     ..increment()
//     ..close();
// }

enum CounterEvent { increment, error }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.error:
        addError(Exception('error!'), StackTrace.current);
        yield state;
        break;
    }
  }

  @override
  void onChange(Change<int> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onEvent(CounterEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}

// Future<void> main(List<String> args) async {
//   final bloc = CounterBloc();
//   print(bloc.state);
//   bloc.add(CounterEvent.increment);
//   await Future.delayed(Duration.zero);
//   print(bloc.state);
//   await bloc.close();
// }

// Future<void> main(List<String> args) async {
//   final bloc = CounterBloc();
//   final subscription = bloc.stream.listen(print);
//   bloc.add(CounterEvent.increment);
//   await Future.delayed(Duration.zero);
//   await subscription.cancel();
//   await bloc.close();
// }

void main(List<String> args) {
  Bloc.observer = SimpleBlocObserver();
  CounterBloc()
    ..add(CounterEvent.increment)
    ..add(CounterEvent.error)
    ..close();
}
