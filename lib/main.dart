import 'dart:io';
import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/routes/app_routes_config.dart';
import 'package:ecommerce/core/service_locator/service_locator.dart';
import 'package:ecommerce/core/styles/app_themes.dart';
import 'package:ecommerce/core/utils/http_overrides.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  await Hive.openBox(EndPoints.cartBox);
   runApp(
    const Ecommerce(),
  );
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          title: 'Ecommerce',
          routerConfig: appRouter,
        );
      },
    );
  }
}
