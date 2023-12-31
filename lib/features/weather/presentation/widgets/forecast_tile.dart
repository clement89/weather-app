import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/strings/strings.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:weather/features/weather/data/models/forecast.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/router/app_router.gr.dart';
import 'package:weather/utils/formatter.dart';

class ForecastTile extends StatelessWidget {
  final Forecast forecast;
  const ForecastTile({
    required this.forecast,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<WeatherBloc>().add(
            GetWeatherHistory(date: Formatter.formatDateApi(forecast.date)));
        final router = AutoRouter.of(context);
        router.push(const HistoryRoute());
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Container(
          width: 0.80.sw,
          color: Theme.of(context).hintColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(forecast.day.condition.icon),
              SizedBox(width: 20.sp),
              Text(Formatter.formatDate(forecast.date)),
              SizedBox(width: 20.sp),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Text(
                        '${Strings.heigh}: ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        state.unit == WeatherUnit.celsius
                            ? '${forecast.day.maxTempC.toStringAsFixed(1)}°C'
                            : '${forecast.day.maxTempF.toStringAsFixed(1)}°F',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' - ${Strings.low}: ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        state.unit == WeatherUnit.celsius
                            ? '${forecast.day.minTempC.toStringAsFixed(1)}°C'
                            : '${forecast.day.minTempF.toStringAsFixed(1)}°F',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
