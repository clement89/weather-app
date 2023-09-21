import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/weather/data/models/forecast.dart';

class ForecastView extends StatelessWidget {
  final List<Forecast> forecastList;
  const ForecastView({
    required this.forecastList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.40.sh,
      child: Column(
        children: [
          const Text('3 Days Forecast'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: forecastList.length,
            itemBuilder: (context, index) {
              Forecast forecast = forecastList[index];
              return SizedBox(
                width: 0.80.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(forecast.day.condition.icon),
                    Text('Day ${index + 1}'),
                    Text(
                      'High: ${forecast.day.maxTempC.toStringAsFixed(1)}°C / Low: ${forecast.day.minTempC.toStringAsFixed(1)}°C',
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
