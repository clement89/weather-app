part of 'weather_bloc.dart';

@immutable
class WeatherState extends Equatable {
  final double latitude;
  final double longitude;
  final String city;

  const WeatherState({
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  factory WeatherState.initial() {
    return const WeatherState(
      latitude: 0.0,
      longitude: 0.0,
      city: '',
    );
  }

  WeatherState copyWith({
    double? latitude,
    double? longitude,
    String? city,
  }) {
    return WeatherState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
    );
  }

  @override
  List<Object> get props => [latitude, longitude, city];
}
