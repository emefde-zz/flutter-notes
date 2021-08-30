import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/theme/cubit/theme_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

import 'helpers/hydrated_bloc.dart';

class MockWeather extends Mock implements Weather {
  MockWeather(this._condition);

  final WeatherCondition _condition;

  @override
  WeatherCondition get condition => _condition;
}

void main() {
  initHydratedBloc();

  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    test('initial state is [default] color', () {
      expect(themeCubit.state, ThemeCubit.defaultColor);
    });

    group('fromJson/toJson', () {
      test('work properly', () {
        expect(themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
            themeCubit.state);
      });
    });

    group('updates theme', () {
      final clearWeather = MockWeather(WeatherCondition.clear);
      final snowyWeather = MockWeather(WeatherCondition.snowy);
      final cloudWeather = MockWeather(WeatherCondition.cloudy);
      final rainyWeather = MockWeather(WeatherCondition.rainy);
      final unknownWeather = MockWeather(WeatherCondition.unknown);

      blocTest<ThemeCubit, Color>(
        'emits [orangeAccent] for weather condition clear.',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(clearWeather),
        expect: () => const <Color>[Colors.orangeAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits [lightBlueAccent] for weather condition snowy.',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(snowyWeather),
        expect: () => const <Color>[Colors.lightBlueAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits [blueGrey] for weather condition cloudy.',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(cloudWeather),
        expect: () => const <Color>[Colors.blueGrey],
      );

      blocTest<ThemeCubit, Color>(
        'emits [indigoAccent] for weather condition cloudy.',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(rainyWeather),
        expect: () => const <Color>[Colors.indigoAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits [default] for weather condition unknown.',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(unknownWeather),
        expect: () => const <Color>[ThemeCubit.defaultColor],
      );
    });
  });
}
