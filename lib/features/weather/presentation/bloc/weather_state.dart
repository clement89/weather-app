part of 'weather_bloc.dart';

@immutable
class WeatherState extends Equatable {
  final double latitude;
  final double longitude;
  final String city;
  final Status status;
  final WeatherResponse weather;
  final Forecast forecast;
  final AppError error;

  const WeatherState({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.status,
    required this.weather,
    required this.forecast,
    required this.error,
  });

  factory WeatherState.initial() {
    return WeatherState(
      latitude: 0.0,
      longitude: 0.0,
      city: '',
      status: Status.initial,
      weather: WeatherResponse.empty(),
      forecast: Forecast.empty(),
      error: AppError.empty(),
    );
  }

  WeatherState copyWith({
    double? latitude,
    double? longitude,
    String? city,
    Status? status,
    WeatherResponse? weather,
    Forecast? forecast,
    AppError? error,
  }) {
    return WeatherState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      status: status ?? this.status,
      weather: weather ?? this.weather,
      forecast: forecast ?? this.forecast,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        latitude,
        longitude,
        city,
        status,
        forecast,
        weather,
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
