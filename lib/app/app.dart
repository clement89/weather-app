import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/di/injection_container.dart';
import 'package:weather/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/router/app_router.dart';
import 'package:weather/theme/theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (BuildContext context) => WeatherBloc(
            repo: serviceLocator(),
          ),
        ),
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) => SettingsCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Weather',
            theme: isDarkMode ? AppTheme.dark : AppTheme.light,
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
