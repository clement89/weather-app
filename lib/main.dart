import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/app/app.dart';
import 'package:weather/core/logs/log_service.dart';
import 'package:weather/di/injection_container.dart';

void main() async {
  await setupInjection();
  final logService = serviceLocator<LogService>();

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();

    runApp(MyApp());
  }, (error, stackTrace) {
    logService.logError('This is an error message.');
  });
}
