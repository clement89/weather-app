import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/strings/strings.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';

class ThemeTile extends StatefulWidget {
  const ThemeTile({super.key});

  @override
  _ThemeTileState createState() => _ThemeTileState();
}

class _ThemeTileState extends State<ThemeTile> {
  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: ListTile(
          title: Text(
            Strings.darkMode,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return isIOS
                  ? CupertinoSwitch(
                      value: state.isDarkMode,
                      onChanged: (newValue) {
                        context
                            .read<SettingsCubit>()
                            .updateTheme(isDarkMode: newValue);
                      },
                    )
                  : Switch(
                      value: state.isDarkMode,
                      onChanged: (newValue) {
                        context
                            .read<SettingsCubit>()
                            .updateTheme(isDarkMode: newValue);
                      },
                    );
            },
          )),
    );
  }
}
