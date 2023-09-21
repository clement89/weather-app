import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:weather/features/settings/presentation/widgets/city_tile.dart';
import 'package:weather/features/settings/presentation/widgets/theme_tile.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/theme/colors.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return _sectionTitle(title: 'Unit', context: context);
                case 1:
                  return _unitTile(unit: WeatherUnit.celsius, context: context);
                case 2:
                  return _unitTile(
                      unit: WeatherUnit.fahrenheit, context: context);
                case 4:
                  return _sectionTitle(title: 'City', context: context);

                case 5:
                  return BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      return CityTile(
                        initialText:
                            '${state.weather.location.name}, ${state.weather.location.country}',
                      );
                    },
                  );
                case 6:
                  return _sectionTitle(title: 'Theme', context: context);
                case 7:
                  return const ThemeTile();
                default:
                  return const SizedBox();
              }
            },
          )),
    );
  }

  Widget _sectionTitle({required String title, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _unitTile({required WeatherUnit unit, required BuildContext context}) {
    return ListTile(
      onTap: () {
        context.read<SettingsCubit>().changeUnit(
              unit == WeatherUnit.celsius
                  ? WeatherUnit.celsius
                  : WeatherUnit.fahrenheit,
            );
      },
      title: Text(unit == WeatherUnit.celsius ? 'Celsius' : 'Fahrenheit',
          style: Theme.of(context).textTheme.bodyLarge),
      trailing: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return state.unit == unit
              ? const Icon(
                  Icons.check,
                  color: AppColors.green,
                )
              : const SizedBox();
        },
      ),
    );
  }
}
