import 'package:weather/features/weather/data/models/day.dart';

class Forecast {
  final String location;
  final Day current;

  Forecast({
    required this.location,
    required this.current,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    try {
      return Forecast(
        location: json['date'],
        current: Day.fromJson(json['day']),
      );
    } catch (e) {
      return Forecast.empty();
    }
  }
  factory Forecast.empty() {
    return Forecast(
      location: '',
      current: Day.empty(),
    );
  }
}
