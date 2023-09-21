import 'package:dartz/dartz.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/features/weather/data/models/forecast.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';

abstract class WeatherRepo {
  Future<Either<AppError, WeatherResponse>> getCurrentWeather({
    double? latitude,
    double? longitude,
    required String apiKey,
    String? city,
  });

  Future<Either<AppError, List<Forecast>>> getWeatherForecast({
    double? latitude,
    double? longitude,
    required String apiKey,
    String? city,
  });
}
