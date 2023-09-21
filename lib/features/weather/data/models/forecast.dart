import 'package:weather/features/weather/data/models/day.dart';

class Forecast {
  final String date;
  final Day day;

  Forecast({
    required this.date,
    required this.day,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    try {
      return Forecast(
        date: json['date'],
        day: Day.fromJson(json['day']),
      );
    } catch (e) {
      return Forecast.empty();
    }
  }
  factory Forecast.empty() {
    return Forecast(
      date: '',
      day: Day.empty(),
    );
  }
}
