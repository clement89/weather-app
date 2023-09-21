part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherForLocation extends WeatherEvent {
  final double latitude;
  final double longitude;
  const GetWeatherForLocation({
    required this.latitude,
    required this.longitude,
  });
}

class GetWeatherForecast extends WeatherEvent {
  final double latitude;
  final double longitude;
  const GetWeatherForecast({
    required this.latitude,
    required this.longitude,
  });
}
