import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/weather/data/models/forecast.dart';
import 'package:weather/features/weather/presentation/widgets/forecast_tile.dart';

class ForecastView extends StatelessWidget {
  final List<Forecast> forecastList;
  const ForecastView({
    required this.forecastList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (forecastList.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 0.40.sh,
      child: Column(
        children: [
          Text(
            '3 Days Forecast',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Padding(
            padding: EdgeInsets.all(20.sp),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: forecastList.length,
              itemBuilder: (context, index) {
                return ForecastTile(forecast: forecastList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
