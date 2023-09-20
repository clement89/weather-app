import 'package:dartz/dartz.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/core/networking/rest_service.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/domain/weather_repo.dart';

class WeatherRepoImpl implements WeatherRepo {
  WeatherRepoImpl({required this.restService});
  final RestService restService;

  @override
  Future<Either<AppError, List<WeatherResponse>>> getCurrentWeather(
      {required double latitude, required double longitude}) {
    // TODO: implement getCurrentWeather
    throw UnimplementedError();
  }
}
