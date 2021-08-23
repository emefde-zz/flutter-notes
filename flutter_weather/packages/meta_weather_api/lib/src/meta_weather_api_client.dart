import 'dart:async';
import 'dart:convert';

import 'package:meta_weather_api/meta_weather_api.dart';

import 'package:http/http.dart' as http;

/// Exception thrown when location search fails
class LocationIdRequestFailure implements Exception {}

/// Exception thrown when provided location could not be found
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

/// {@template meta_weather_api_client}
/// Dart API Client which wraps the [MetaWeather API](https://www.metaweather.com/api/).
/// {@endtemplate}
class MetaWeatherAPIClient {
  /// {@macro meta_weather_api_client}
  const MetaWeatherAPIClient({required http.Client client}) : _client = client;
  final http.Client _client;

  static const _baseURL = 'www.metaweather.com';

  /// Finds a [Location] `/api/location/search/?query=(query)`.
  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseURL,
      '/api/location/search',
      <String, String>{'query': query},
    );
    final locationResponse = await _client.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationIdRequestFailure();
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    if (locationJson.isEmpty) throw LocationNotFoundFailure();

    return locationFromJson(locationJson.first);
  }

  /// Fetch [Weather] for given [locationId]
  Future<Weather> getWeather(int locationId) async {
    final weatherRequest = Uri.https(_baseURL, 'api/location/$locationId');
    final weatherResponse = await _client.get(weatherRequest);

    if (weatherResponse.statusCode != 200) throw WeatherRequestFailure();

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) throw WeatherNotFoundFailure();

    final weatherJson = bodyJson['consolidated_weather'] as List;

    if (weatherJson.isEmpty) throw WeatherNotFoundFailure();

    return weatherFromJson(weatherJson.first);
  }
}
