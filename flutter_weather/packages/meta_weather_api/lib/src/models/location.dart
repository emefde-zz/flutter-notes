import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

enum LocationType {
  @JsonValue('City')
  city,
  @JsonValue('Region')
  region,
  @JsonValue('State')
  state,
  @JsonValue('Province')
  province,
  @JsonValue('Country')
  country,
  @JsonValue('Continent')
  continent
}

@JsonSerializable()
class Location {
  Location({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  final String title;
  final LocationType locationType;
  final int woeid;
  @JsonKey(name: 'latt_long')
  @LatLongConverter()
  final LatLng lattLong;
}

class LatLng {
  const LatLng({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

class LatLongConverter implements JsonConverter<LatLng, String> {
  const LatLongConverter();

  @override
  String toJson(LatLng latLng) {
    return '${latLng.latitude},${latLng.longitude}';
  }

  @override
  LatLng fromJson(String json) {
    final split = json.split(',');
    return LatLng(
        latitude: double.tryParse(split.first) ?? 0,
        longitude: double.tryParse(split.last) ?? 0);
  }
}
