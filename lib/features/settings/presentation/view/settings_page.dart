import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:weather/features/settings/presentation/widgets/city_tile.dart';
import 'package:weather/features/settings/presentation/widgets/section_tile.dart';
import 'package:weather/features/settings/presentation/widgets/theme_tile.dart';
import 'package:weather/features/settings/presentation/widgets/unit_tile.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';

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
                  return const SectionTile(title: 'Unit');
                case 1:
                  return const UnitTile(unit: WeatherUnit.celsius);
                case 2:
                  return const UnitTile(unit: WeatherUnit.fahrenheit);
                case 4:
                  return const SectionTile(title: 'City');

                case 5:
                  return BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      return CityTile(
                        initialText: state.city,
                      );
                    },
                  );
                case 6:
                  return const SectionTile(title: 'Theme');
                case 7:
                  return const ThemeTile();
                default:
                  return const SizedBox();
              }
            },
          )),
    );
  }
}
