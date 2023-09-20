import 'package:get_it/get_it.dart';
import 'package:weather/core/logs/log_service.dart';
import 'package:weather/core/networking/rest_service.dart';
import 'package:weather/features/weather/data/weather_repo_impl.dart';
import 'package:weather/features/weather/domain/weather_repo.dart';

final serviceLocator = GetIt.instance;

Future<void> setupInjection() async {
  serviceLocator
    ..registerLazySingleton<LogService>(() => LogService())
    ..registerLazySingleton<RestService>(() => RestService())
    ..registerLazySingleton<WeatherRepo>(
      () => WeatherRepoImpl(
        restService: serviceLocator(),
      ),
    );
}
