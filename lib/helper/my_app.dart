import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/app/app_routes.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/helper/languages.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      defaultTransition: Transition.fade,
      getPages: AppRoutes().pagesRoutes,
      locale: const Locale('en'),
      translations: Languages(),
      theme: appTheme.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
