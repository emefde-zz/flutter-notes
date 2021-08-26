import 'package:meta_weather_api/meta_weather_api.dart' as meta_weather_api;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

class MockMetaWeatherAPIClient extends Mock
    implements meta_weather_api.MetaWeatherAPIClient {}

class MockWeather extends Mock implements meta_weather_api.Weather {}

class MockLocation extends Mock implements meta_weather_api.Location {}

void main() {
  group('WeatherRepository', () {
    late MockMetaWeatherAPIClient mockMetaWeatherAPIClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      mockMetaWeatherAPIClient = MockMetaWeatherAPIClient();
      weatherRepository =
          WeatherRepository(apiClient: mockMetaWeatherAPIClient);
    });

    group('constructor', () {
      test('weatherRepository is not null', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('getWeather', () {
      const city = 'london';
      const woeid = 44418;

      test('calls locationSearch with correct city', () async {
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(() => mockMetaWeatherAPIClient.locationSearch(city)).called(1);
      });

      test('throws when location search fails', () async {
        final exception = Exception('whoops');
        when(() => mockMetaWeatherAPIClient.locationSearch(city))
            .thenThrow(exception);
        expect(() async => await weatherRepository.getWeather(city),
            throwsA(exception));
      });

      test('calls getWeather with correct woeid', () async {
        final location = MockLocation();
        when(() => location.woeid).thenReturn(woeid);
        when(() => mockMetaWeatherAPIClient.locationSearch(any()))
            .thenAnswer((_) async => location);
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(() => mockMetaWeatherAPIClient.getWeather(woeid)).called(1);
      });

      test('throws when getWeather fails', () async {
        final location = MockLocation();
        final exception = Exception('whoops');
        when(() => location.woeid).thenReturn(woeid);
        when(() => mockMetaWeatherAPIClient.locationSearch(city))
            .thenAnswer((_) async => location);
        when(() => mockMetaWeatherAPIClient.getWeather(woeid))
            .thenThrow(exception);
        expect(() async => await weatherRepository.getWeather(city),
            throwsA(exception));
      });

      test('returns correct [Weather] on success', () async {
        final location = MockLocation();
        final weather = MockWeather();
        when(() => location.woeid).thenReturn(woeid);
        when(() => location.title).thenReturn('London');
        when(() => weather.weatherStateAbbr)
            .thenReturn(meta_weather_api.WeatherState.clear);
        when(() => weather.theTemp).thenReturn(28.0);
        when(() => mockMetaWeatherAPIClient.locationSearch(city))
            .thenAnswer((_) async => location);
        when(() => mockMetaWeatherAPIClient.getWeather(woeid))
            .thenAnswer((_) async => weather);
        final result = await weatherRepository.getWeather(city);
        expect(
            result,
            isA<Weather>()
                .having((w) => w.temperature, 'temp', 28.0)
                .having((w) => w.location, 'city name', 'London')
                .having((w) => w.condition, 'weather condition',
                    WeatherCondition.clear));
      });
    });
  });
}
