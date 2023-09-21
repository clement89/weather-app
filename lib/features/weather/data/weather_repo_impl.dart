import 'package:dartz/dartz.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/core/networking/rest_service.dart';
import 'package:weather/features/weather/data/models/forecast.dart';
import 'package:weather/features/weather/data/models/hour.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/domain/weather_repo.dart';

class WeatherRepoImpl implements WeatherRepo {
  final RestService restService;
  WeatherRepoImpl({required this.restService});

  @override
  Future<Either<AppError, WeatherResponse>> getCurrentWeather({
    double? latitude,
    double? longitude,
    required String apiKey,
    String? city,
  }) async {
    try {
      String query = '$latitude,$longitude';
      if (city != null) {
        query = city;
      }
      final res = await restService.getDataFromServer(
        url: '/current.json?q=$query&key=$apiKey',
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
    double? latitude,
    double? longitude,
    required String apiKey,
    String? city,
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

  @override
  Future<Either<AppError, List<Hour>>> getWeatherHistory({
    required double latitude,
    required double longitude,
    required String apiKey,
    required String date,
  }) async {
    try {
      final res = await restService.getDataFromServer(
        url: '/history.json?q=$latitude,$longitude&dt=$date&key=$apiKey',
        header: {},
      );
      if (res.isError) {
        return const Left(
            AppError(message: 'Failed to get characters from server'));
      } else {
        List<Hour> hourList = [];
        final forecastData = res.data['forecast'];
        List<dynamic> forecastDay = forecastData['forecastday'];
        dynamic forecast = forecastDay.first;
        List<dynamic> hourDataList = forecast['hour'];

        for (var hourData in hourDataList) {
          hourList.add(Hour.fromJson(hourData));
        }
        return Right(hourList);
      }
    } catch (e) {
      return Left(AppError(message: e.toString()));
    }
  }
}
