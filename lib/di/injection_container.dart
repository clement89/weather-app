import 'package:get_it/get_it.dart';
import 'package:weather/core/logs/log_service.dart';
import 'package:weather/core/networking/rest_service.dart';

final serviceLocator = GetIt.instance;

Future<void> setupInjection() async {
  serviceLocator
    ..registerLazySingleton<LogService>(() => LogService())
    ..registerLazySingleton<RestService>(() => RestService());
}
