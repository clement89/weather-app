import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:weather/features/weather/data/models/hour.dart';
import 'package:weather/utils/formatter.dart';

class HistoryTile extends StatelessWidget {
  final Hour hour;
  const HistoryTile({
    required this.hour,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        width: 0.80.sw,
        color: Theme.of(context).hintColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(5.sp),
              child: Image.network(hour.condition.icon),
            ),
            SizedBox(width: 20.sp),
            Text(
              Formatter.formatTime(hour.time),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(width: 20.sp),
            Expanded(
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Text(
                        'Feeling: ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        state.unit == WeatherUnit.celsius
                            ? '${hour.feelslikeC.toStringAsFixed(1)}°C'
                            : '${hour.feelslikeC.toStringAsFixed(1)}°F',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Humidity',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                    '${hour.humidity}%',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
