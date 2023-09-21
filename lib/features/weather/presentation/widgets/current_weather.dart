import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherResponse weather;
  const CurrentWeather({
    required this.weather,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              if (state.unit == WeatherUnit.celsius) {}
              return Text(
                state.unit == WeatherUnit.celsius
                    ? '${weather.current.temp_c}°C'
                    : '${weather.current.temp_f}°F',
                style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.titleLarge!.color),
              );
            },
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
