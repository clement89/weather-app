import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
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
    await EasyLocalization.ensureInitialized();
    await ScreenUtil.ensureScreenSize();

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', '')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', ''),
        startLocale: const Locale('en', ''), // Default starting locale
        saveLocale:
            false, // Whether to save the selected locale to device storage
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) {
    logService.logError('This is an error message.');
  });
}
