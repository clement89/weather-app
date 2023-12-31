import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/logs/log_service.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/di/injection_container.dart';
import 'package:weather/features/weather/data/models/forecast.dart';
import 'package:weather/features/weather/data/models/hour.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/domain/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final logService = serviceLocator<LogService>();
  final WeatherRepo repo;
  final String key;

  WeatherBloc({
    required this.repo,
    required this.key,
  }) : super(WeatherState.initial()) {
    on<GetCurrentWeather>(_getWeatherForLocation);
    on<GetWeatherForecast>(_getWeatherForecast);
    on<GetWeatherHistory>(_getWeatherHistory);
  }

  Future<void> _getWeatherForLocation(
    GetCurrentWeather event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
      ));
      final res = event.isFromCity
          ? await repo.getCurrentWeather(
              city: event.city!,
              apiKey: key,
            )
          : await repo.getCurrentWeather(
              latitude: event.latitude!,
              longitude: event.longitude!,
              apiKey: key,
            );
      res.fold(
        (l) {
          emit(state.copyWith(status: Status.error, error: l));
        },
        (r) {
          emit(state.copyWith(
            status: Status.loaded,
            weather: r,
            city: '${r.location.name}, ${r.location.country}',
          ));
        },
      );
    } catch (error) {
      logService.logError(error.toString());
    }
  }

  Future<void> _getWeatherForecast(
    GetWeatherForecast event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
      ));
      final res = await repo.getWeatherForecast(
        latitude: event.latitude,
        longitude: event.longitude,
        apiKey: key,
      );
      res.fold(
        (l) {
          emit(state.copyWith(status: Status.error, error: l));
        },
        (r) {
          emit(state.copyWith(status: Status.loaded, forecastList: r));
        },
      );
    } catch (error) {
      logService.logError(error.toString());
    }
  }

  Future<void> _getWeatherHistory(
    GetWeatherHistory event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
      ));

      final res = state.city.isEmpty
          ? await repo.getWeatherHistory(
              latitude: state.latitude,
              longitude: state.longitude,
              apiKey: key,
              date: event.date,
            )
          : await repo.getWeatherHistory(
              city: state.city,
              apiKey: key,
              date: event.date,
            );
      res.fold(
        (l) {
          emit(state.copyWith(status: Status.error, error: l));
        },
        (r) {
          emit(state.copyWith(status: Status.loaded, history: r));
        },
      );
    } catch (error) {
      logService.logError(error.toString());
    }
  }
}
