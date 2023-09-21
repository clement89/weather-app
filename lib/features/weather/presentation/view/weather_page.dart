import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/location/location_service.dart';
import 'package:weather/di/injection_container.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather/presentation/widgets/current_weather.dart';
import 'package:weather/features/weather/presentation/widgets/forecast_view.dart';
import 'package:weather/router/app_router.gr.dart';
import 'package:weather/widgets/custom_loader.dart';

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

        _bloc.add(GetWeatherForecast(
          latitude: position.latitude,
          longitude: position.longitude,
        ));
      },
      onFailure: (FailureType type, String? message) {
        _bloc.add(const GetWeatherForLocation(
          latitude: 9.796600,
          longitude: 76.482231,
        ));
        _bloc.add(const GetWeatherForecast(
          latitude: 9.796600,
          longitude: 76.482231,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                final router = AutoRouter.of(context);
                router.push(const SettingsRoute());
              },
            ),
          ],
        ),
        body: Container(
          color: theme.scaffoldBackgroundColor,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(
                  child: CustomLoader(),
                );
              } else if (state.status == Status.error) {
                return Center(
                  child: Text(state.error.message),
                );
              }
              return Column(
                children: [
                  SizedBox(height: 40.sp),
                  CurrentWeather(weather: state.weather),
                  SizedBox(height: 40.sp),
                  ForecastView(forecastList: state.forecastList),
                ],
              );
            },
          ),
        ));
  }
}
