import 'package:dartz/dartz.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/core/networking/rest_service.dart';
import 'package:weather/env/env.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/domain/weather_repo.dart';

class WeatherRepoImpl implements WeatherRepo {
  WeatherRepoImpl({required this.restService});
  final RestService restService;

  //https://api.weatherapi.com/v1/current.json?q=London&key=4915ce97206946f69ae74642232009

  @override
  Future<Either<AppError, WeatherResponse>> getCurrentWeather(
      {required double latitude, required double longitude}) async {
    try {} catch (e) {
      return Left(AppError(message: e.toString()));
    }
    final res = await restService.getDataFromServer(
      url: '/current.json?q=$latitude,$longitude&key=${Env.key}',
      header: {},
    );
    if (res.isError) {
      return const Left(
          AppError(message: 'Failed to get characters from server'));
    } else {
      final WeatherResponse response = WeatherResponse.fromJson(res.data);
      return Right(response);
    }
  }
}
