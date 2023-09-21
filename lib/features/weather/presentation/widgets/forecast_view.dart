import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/weather/data/models/forecast.dart';
import 'package:weather/utils/formatter.dart';

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
                Forecast forecast = forecastList[index];
                return Padding(
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
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'High: ',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text:
                                    '${forecast.day.maxTempC.toStringAsFixed(1)}°C',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' / Low: ',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text:
                                    '${forecast.day.minTempC.toStringAsFixed(1)}°C',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
