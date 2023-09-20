import 'package:weather/features/weather/data/models/current.dart';
import 'package:weather/features/weather/data/models/location.dart';

class WeatherResponse {
  final Location location;
  final Current current;

  WeatherResponse({
    required this.location,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }
}