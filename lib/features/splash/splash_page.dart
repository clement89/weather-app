import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/weather/presentation/view/weather_page.dart';
import 'package:weather/router/app_router.gr.dart';
import 'package:weather/utils/asset_paths.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      final router = AutoRouter.of(context);
      router.replace(const WeatherRoute());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Center(
              child: Image.asset(
                AssetPaths.logo,
                width: 200.sp,
                height: 200.sp,
              ),
            );
          }),
    );
  }
}
