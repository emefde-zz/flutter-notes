import 'package:meta_weather_api/meta_weather_api.dart' as meta_weather_api;
import 'package:mocktail/mocktail.dart';

class MockMetaWeatherAPIClient extends Mock
    implements meta_weather_api.MetaWeatherAPIClient {}

class MockWeather extends Mock implements meta_weather_api.Weather {}

class MockLocation extends Mock implements meta_weather_api.Location {}

void main() {}
