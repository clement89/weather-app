import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/logs/log_service.dart';
import 'package:weather/di/injection_container.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final logService = serviceLocator<LogService>();

  WeatherBloc() : super(WeatherState.initial()) {
    on<GetWeatherForLocation>(_getWeatherForLocation);
  }

  Future<void> _getWeatherForLocation(
    GetWeatherForLocation event,
    Emitter<WeatherState> emit,
  ) async {
    try {} catch (error) {
      logService.logError(error.toString());
    }
  }
}
