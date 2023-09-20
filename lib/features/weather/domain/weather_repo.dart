import 'package:dartz/dartz.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';

abstract class WeatherRepo {
  Future<Either<AppError, WeatherResponse>> getCurrentWeather({
    required double latitude,
    required double longitude,
  });
}
