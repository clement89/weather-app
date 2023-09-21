import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/location/location_service.dart';
import 'package:weather/di/injection_container.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
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
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
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
          return _weatherInfo(weather: state.weather);
        },
      ),
    ));
  }

  Widget _weatherInfo({required WeatherResponse weather}) {
    final theme = Theme.of(context); // Get the current theme

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (weather.current.condition.icon.isNotEmpty)
            Image.network(
              weather.current.condition.icon,
            ),
          SizedBox(
            width: 0.70.sw,
            child: Text(
              '${weather.location.name}, ${weather.location.country}',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.sp),
          Text(
            '${weather.current.temp_c}°C',
            style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleLarge!.color),
          ),
          SizedBox(height: 20.sp),
          Text(
            weather.current.condition.text,
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 20.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Wind', style: theme.textTheme.bodyMedium),
                  Text(
                    '${weather.current.wind_kph} km/h',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(width: 20.w),
              Column(
                children: [
                  Text('Humidity', style: theme.textTheme.bodyMedium),
                  Text(
                    '${weather.current.humidity}%',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(width: 20.w),
              Column(
                children: [
                  Text('Precipitation', style: theme.textTheme.bodyMedium),
                  Text(
                    '${weather.current.precip_mm} mm',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
