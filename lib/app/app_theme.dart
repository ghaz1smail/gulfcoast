import 'package:flutter/material.dart';

class AppTheme {
  Color primaryColor = const Color(0xff1E2A5E),
      secondory = const Color(0xff55679C),
      lightColor = const Color(0xff7C93C3),
      backgroundColor = const Color(0xffE1D7B7);

  ThemeData theme = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xff1A4D2E),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff1A4D2E),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ));
}
