import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _bloc.add(const GetWeatherForLocation(
      latitude: 9.796600,
      longitude: 76.482231,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
