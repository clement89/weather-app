import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/location/location_service.dart';
import 'package:weather/di/injection_container.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';

@RoutePage()
class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WeatherBloc>();

    final locationService = serviceLocator<LocationService>();
    locationService.fetchLocation(
      onSuccess: (Position position) {
        _bloc.add(GetWeatherForLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        ));
      },
      onFailure: (FailureType type, String? message) {
        _bloc.add(const GetWeatherForLocation(
          latitude: 9.796600,
          longitude: 76.482231,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
