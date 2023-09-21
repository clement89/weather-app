part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentWeather extends WeatherEvent {
  final bool isFromCity;
  final double? latitude;
  final double? longitude;
  final String? city;

  const GetCurrentWeather({
    required this.isFromCity,
    this.latitude,
    this.longitude,
    this.city,
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
