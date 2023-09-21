import 'package:weather/features/weather/data/models/current.dart';

class Day {
  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
  final double avgTempC;
  final double avgTempF;
  final double maxWindMph;
  final double maxWindKph;
  final double totalPrecipMm;
  final double totalPrecipIn;
  final double totalSnowCm;
  final double avgVisKm;
  final double avgVisMiles;
  final int avgHumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final Condition condition;
  final int uv;

  Day({
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
    required this.avgTempC,
    required this.avgTempF,
    required this.maxWindMph,
    required this.maxWindKph,
    required this.totalPrecipMm,
    required this.totalPrecipIn,
    required this.totalSnowCm,
    required this.avgVisKm,
    required this.avgVisMiles,
    required this.avgHumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxTempC: json['maxtemp_c'] as double,
      maxTempF: json['maxtemp_f'] as double,
      minTempC: json['mintemp_c'] as double,
      minTempF: json['mintemp_f'] as double,
      avgTempC: json['avgtemp_c'] as double,
      avgTempF: json['avgtemp_f'] as double,
      maxWindMph: json['maxwind_mph'] as double,
      maxWindKph: json['maxwind_kph'] as double,
      totalPrecipMm: json['totalprecip_mm'] as double,
      totalPrecipIn: json['totalprecip_in'] as double,
      totalSnowCm: json['totalsnow_cm'] as double,
      avgVisKm: json['avgvis_km'] as double,
      avgVisMiles: json['avgvis_miles'] as double,
      avgHumidity: json['avghumidity'] as int,
      dailyWillItRain: json['daily_will_it_rain'] as int,
      dailyChanceOfRain: json['daily_chance_of_rain'] as int,
      dailyWillItSnow: json['daily_will_it_snow'] as int,
      dailyChanceOfSnow: json['daily_chance_of_snow'] as int,
      condition: Condition.fromJson(json['condition']),
      uv: json['uv'] as int,
    );
  }

  factory Day.empty() {
    return Day(
      maxTempC: 0,
      maxTempF: 0,
      minTempC: 0,
      minTempF: 0,
      avgTempC: 0,
      avgTempF: 0,
      maxWindMph: 0,
      maxWindKph: 0,
      totalPrecipMm: 0,
      totalPrecipIn: 0,
      totalSnowCm: 0,
      avgVisKm: 0,
      avgVisMiles: 0,
      avgHumidity: 0,
      dailyWillItRain: 0,
      dailyChanceOfRain: 0,
      dailyWillItSnow: 0,
      dailyChanceOfSnow: 0,
      condition: Condition.empty(),
      uv: 0,
    );
  }
}
