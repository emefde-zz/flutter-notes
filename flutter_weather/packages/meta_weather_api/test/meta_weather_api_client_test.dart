import 'package:http/http.dart' as http;
import 'package:meta_weather_api/meta_weather_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'meta_weather_api_client_test.mocks.dart';

@GenerateMocks([http.Client, http.Response])
void main() {
  group('MetaWeatherAPIClient', () {
    late MockClient httpClient;
    late MetaWeatherAPIClient weatherAPIClient;

    setUp(() {
      httpClient = MockClient();
      weatherAPIClient = MetaWeatherAPIClient(client: httpClient);
    });
    group('locationSearch', () {
      final mockQuery = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn('');
        when(httpClient.get(any)).thenAnswer((_) async => response);

        try {
          await weatherAPIClient.locationSearch(mockQuery);
        } catch (_) {}
        verify(httpClient.get(Uri.https(
          'www.metaweather.com',
          '/api/location/search',
          <String, String>{'query': mockQuery},
        ))).called(1);
      });

      test('throws when status code is not 200', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(400);
        when(response.body).thenReturn('');
        when(httpClient.get(any)).thenAnswer((_) async => response);
        await expectLater(weatherAPIClient.locationSearch(mockQuery),
            throwsA(isA<LocationIdRequestFailure>()));
      });

      test('throws when response body is empty', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn('[]');
        when(httpClient.get(any)).thenAnswer((_) async => response);
        await expectLater(weatherAPIClient.locationSearch(mockQuery),
            throwsA(isA<LocationNotFoundFailure>()));
      });

      test('returns [Location] on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn('''[{
            "title": "mock-title",
            "location_type": "City",
            "latt_long": "-34.75,83.28",
            "woeid": 42
          }]''');
        when(httpClient.get(any)).thenAnswer((_) async => response);

        final actual = await weatherAPIClient.locationSearch(mockQuery);
        expect(
            actual,
            isA<Location>()
                .having((loc) => loc.title, 'title', 'mock-title')
                .having((loc) => loc.locationType, 'location type',
                    LocationType.city)
                .having(
                    (loc) => loc.lattLong,
                    'latitude, longitude',
                    isA<LatLng>()
                        .having((latLng) => latLng.latitude, 'latitude', -34.75)
                        .having(
                            (latLng) => latLng.longitude, 'longitude', 83.28))
                .having((loc) => loc.woeid, 'woeid', 42));
      });
    });

    group('getWeather', () {
      final locationId = 123;
      test('makes correct http request', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn('');
        when(httpClient.get(any)).thenAnswer((_) async => response);

        try {
          await weatherAPIClient.getWeather(locationId);
        } catch (_) {}
        verify(httpClient.get(Uri.https(
          'www.metaweather.com',
          '/api/location/$locationId',
        ))).called(1);
      });

      test('throws when status code is not 200', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(400);
        when(response.body).thenReturn('');
        when(httpClient.get(any)).thenAnswer((_) async => response);
        await expectLater(weatherAPIClient.getWeather(locationId),
            throwsA(isA<WeatherRequestFailure>()));
      });

      test('throws [WeatherNotFoundFailure] when response body is empty',
          () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn('{}');
        when(httpClient.get(any)).thenAnswer((_) async => response);
        await expectLater(weatherAPIClient.getWeather(locationId),
            throwsA(isA<WeatherNotFoundFailure>()));
      });

      test('throws [WeatherNotFoundFailure] when weather is empty', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn('{"consolidated_weather" : []}');
        when(httpClient.get(any)).thenAnswer((_) async => response);
        await expectLater(weatherAPIClient.getWeather(locationId),
            throwsA(isA<WeatherNotFoundFailure>()));
      });

      test('returns [Weather] on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn('''
          {"consolidated_weather":[{
            "id":4907479830888448,
            "weather_state_name":"Showers",
            "weather_state_abbr":"s",
            "wind_direction_compass":"SW",
            "created":"2020-10-26T00:20:01.840132Z",
            "applicable_date":"2020-10-26",
            "min_temp":7.9399999999999995,
            "max_temp":13.239999999999998,
            "the_temp":12.825,
            "wind_speed":7.876886316914553,
            "wind_direction":246.17046093256732,
            "air_pressure":997.0,
            "humidity":73,
            "visibility":11.037727173307882,
            "predictability":73
          }]}
        ''');

        when(httpClient.get(any)).thenAnswer((_) async => response);

        final actual = await weatherAPIClient.getWeather(locationId);
        expect(
          actual,
          isA<Weather>()
              .having((weather) => weather.id, 'id', 4907479830888448)
              .having((weather) => weather.weatherStateName, 'state name',
                  'Showers')
              .having((weather) => weather.weatherStateAbbr, 'state abbr',
                  WeatherState.showers)
              .having((weather) => weather.windDirectionCompass,
                  'wind direction compass', WindDirectionCompass.southWest)
              .having((w) => w.created, 'created',
                  DateTime.parse('2020-10-26T00:20:01.840132Z'))
              .having((w) => w.applicableDate, 'applicableDate',
                  DateTime.parse('2020-10-26'))
              .having((w) => w.minTemp, 'minTemp', 7.9399999999999995)
              .having((w) => w.maxTemp, 'maxTemp', 13.239999999999998)
              .having((w) => w.theTemp, 'theTemp', 12.825)
              .having((w) => w.windSpeed, 'windSpeed', 7.876886316914553)
              .having(
                  (w) => w.windDirection, 'windDirection', 246.17046093256732)
              .having((w) => w.airPressure, 'airPressure', 997.0)
              .having((w) => w.humidity, 'humidity', 73)
              .having((w) => w.visibility, 'visibility', 11.037727173307882)
              .having((w) => w.predictability, 'predictability', 73),
        );
      });
    });
  });
}
