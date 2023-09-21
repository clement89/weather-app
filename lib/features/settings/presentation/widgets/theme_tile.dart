import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';

class ThemeTile extends StatefulWidget {
  const ThemeTile({super.key});

  @override
  _ThemeTileState createState() => _ThemeTileState();
}

class _ThemeTileState extends State<ThemeTile> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return ListTile(
      title: Text(
        'Dark mode',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: isIOS
          ? CupertinoSwitch(
              value: switchValue,
              onChanged: (newValue) {
                context
                    .read<SettingsCubit>()
                    .updateTheme(isDarkMode: switchValue);
              },
            )
          : Switch(
              value: switchValue,
              onChanged: (newValue) {
                context
                    .read<SettingsCubit>()
                    .updateTheme(isDarkMode: switchValue);
              },
            ),
    );
  }
}
