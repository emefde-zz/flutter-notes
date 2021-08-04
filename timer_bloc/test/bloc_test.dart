import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timer_bloc/bloc/timer_bloc.dart';
import 'package:timer_bloc/data/ticker.dart';

class MockTimerBloc extends MockBloc<TimerEvent, TimerState> implements TimerBloc {}
class MockTicker extends Mock implements Ticker {}

class TimerEventFake extends Fake implements TimerEvent {}
class TimerStateFake extends Fake implements TimerState {}


void main() {

  setUpAll(() {
    registerFallbackValue<TimerState>(TimerStateFake());
    registerFallbackValue<TimerEvent>(TimerEventFake());
  });

  group('testing bloc', () {

    late TimerBloc bloc;
    late TimerBloc mockBloc;

    setUp(() {
      bloc = TimerBloc(ticker: Ticker());
      mockBloc = MockTimerBloc();
    });

    tearDown(() {
      bloc.close();
      mockBloc.close();
    });

    blocTest<TimerBloc, TimerState>(
      'emits TimerRunInProgress when TimerStarted is added',
        build: () => bloc,
        act: (bloc) => bloc.add(TimerStarted(duration: 5)),
        expect: () => const <TimerState>[TimerRunInProgress(5)]
    );

    test('initial state is TimerInitial(60)', () {
      expect(bloc.state, TimerInitial(60));
    });

  });

  group('whenListen', () {
    test("Let's mock the CounterBloc's stream!", () {
      // Create Mock CounterBloc Instance
      final bloc = MockTimerBloc();

      // Stub the listen with a fake Stream
      whenListen(
          bloc,
          Stream.fromIterable([
            TimerInitial(5),
            TimerRunInProgress(3),
            TimerRunPause(1)
          ])
      );

      // Expect that the CounterBloc instance emitted the stubbed Stream of
      // states
      expectLater(
          bloc.stream,
          emitsInOrder([
            TimerInitial(5),
            TimerRunInProgress(3),
            TimerRunPause(1)
          ])
      );
    });
  });

}
