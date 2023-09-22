import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/strings/strings.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:weather/theme/colors.dart';

class UnitTile extends StatelessWidget {
  final WeatherUnit unit;
  const UnitTile({
    required this.unit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<SettingsCubit>().changeUnit(
              unit == WeatherUnit.celsius
                  ? WeatherUnit.celsius
                  : WeatherUnit.fahrenheit,
            );
      },
      title: Text(
          unit == WeatherUnit.celsius ? Strings.celsius : Strings.fahrenheit,
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
