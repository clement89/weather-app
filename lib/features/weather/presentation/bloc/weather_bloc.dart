import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/logs/log_service.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/di/injection_container.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/domain/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final logService = serviceLocator<LogService>();
  final WeatherRepo repo;

  WeatherBloc({required this.repo}) : super(WeatherState.initial()) {
    on<GetWeatherForLocation>(_getWeatherForLocation);
  }

  Future<void> _getWeatherForLocation(
    GetWeatherForLocation event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
      ));
      final res = await repo.getCurrentWeather(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      res.fold(
        (l) {
          emit(state.copyWith(status: Status.error, error: l));
        },
        (r) {
          logService.logInfo('Got here');
        },
      );
    } catch (error) {
      logService.logError(error.toString());
    }
  }
}
