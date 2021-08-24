import 'package:json_annotation/json_annotation.dart';
import 'package:meta_weather_api/meta_weather_api.dart';
import 'package:test/test.dart';

main() {
  group('Location test', () {
    group('fromJson', () {
      test('throws CheckedFromJsonException when enum is [unknown]', () {
        expect(
            () => Location.fromJson({
                  'title': 'mock-title',
                  'location_type': 'Unknown',
                  'latt_long': '-34.75,83.28',
                  'woeid': 42
                }),
            throwsA(isA<CheckedFromJsonException>()));
      });

      test('initializes with proper values', () {
        final location = Location.fromJson({
          'title': 'mock-title',
          'location_type': 'State',
          'latt_long': '-34.75,83.28',
          'woeid': 42
        });
        expect(location.lattLong.latitude, -34.75);
        expect(location.lattLong.longitude, 83.28);
        expect(location.title, 'mock-title');
        expect(location.woeid, 42);
        expect(location.locationType, LocationType.state);
      });
    });
  });
}
