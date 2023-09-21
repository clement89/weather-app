import 'package:equatable/equatable.dart';
import 'package:weather/features/weather/data/models/current.dart';
import 'package:weather/features/weather/data/models/location.dart';

class WeatherResponse extends Equatable {
  final Location location;
  final Current current;

  const WeatherResponse({
    required this.location,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherResponse(
        location: Location.fromJson(json['location']),
        current: Current.fromJson(json['current']),
      );
    } catch (e) {
      return WeatherResponse.empty();
    }
  }
  factory WeatherResponse.empty() {
    return WeatherResponse(
      location: Location.empty(),
      current: Current.empty(),
    );
  }
  @override
  List<Object?> get props => [location, current];
}
