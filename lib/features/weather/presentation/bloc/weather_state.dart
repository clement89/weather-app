part of 'weather_bloc.dart';

@immutable
class WeatherState extends Equatable {
  final double latitude;
  final double longitude;
  final String city;
  final Status status;
  final WeatherResponse weather;
  final List<Forecast> forecastList;
  final List<Hour> history;
  final AppError error;

  const WeatherState({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.status,
    required this.weather,
    required this.forecastList,
    required this.history,
    required this.error,
  });

  factory WeatherState.initial() {
    return WeatherState(
      latitude: 0.0,
      longitude: 0.0,
      city: '',
      status: Status.initial,
      weather: WeatherResponse.empty(),
      forecastList: const [],
      history: const [],
      error: AppError.empty(),
    );
  }

  WeatherState copyWith({
    double? latitude,
    double? longitude,
    String? city,
    Status? status,
    WeatherResponse? weather,
    List<Forecast>? forecastList,
    List<Hour>? history,
    AppError? error,
  }) {
    return WeatherState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      status: status ?? this.status,
      weather: weather ?? this.weather,
      forecastList: forecastList ?? this.forecastList,
      history: history ?? this.history,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        latitude,
        longitude,
        city,
        status,
        weather,
        forecastList,
        history,
        error,
      ];
}

enum Status {
  initial,
  loading,
  loaded,
  error,
  empty,
}
