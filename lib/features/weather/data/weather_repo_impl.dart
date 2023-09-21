import 'package:dartz/dartz.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/core/networking/rest_service.dart';
import 'package:weather/features/weather/data/models/forecast.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/domain/weather_repo.dart';

class WeatherRepoImpl implements WeatherRepo {
  final RestService restService;
  WeatherRepoImpl({required this.restService});

  //https://api.weatherapi.com/v1/current.json?q=London&key=4915ce97206946f69ae74642232009

  @override
  Future<Either<AppError, WeatherResponse>> getCurrentWeather({
    required double latitude,
    required double longitude,
    required String apiKey,
  }) async {
    try {
      final res = await restService.getDataFromServer(
        url: '/current.json?q=$latitude,$longitude&key=$apiKey',
        header: {},
      );
      if (res.isError) {
        return const Left(
            AppError(message: 'Failed to get characters from server'));
      } else {
        final WeatherResponse response = WeatherResponse.fromJson(res.data);
        return Right(response);
      }
    } catch (e) {
      return Left(AppError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<Forecast>>> getWeatherForecast({
    required double latitude,
    required double longitude,
    required String apiKey,
  }) async {
    try {
      final res = await restService.getDataFromServer(
        url: '/forecast.json?q=$latitude,$longitude&days=3&key=$apiKey',
        header: {},
      );
      if (res.isError) {
        return const Left(
            AppError(message: 'Failed to get characters from server'));
      } else {
        List<Forecast> forecastList = [];
        final forecastData = res.data['forecast'];
        List<dynamic> forecastDay = forecastData['forecastday'];
        for (var forecast in forecastDay) {
          forecastList.add(Forecast.fromJson(forecast));
        }

        return Right(forecastList);
      }
    } catch (e) {
      return Left(AppError(message: e.toString()));
    }
  }
}
