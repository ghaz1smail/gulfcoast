import 'package:flutter/material.dart';

class AppTheme {
  Color primaryColor = const Color(0xff1E2A5E),
      secondory = const Color(0xff55679C),
      lightColor = const Color(0xff7C93C3),
      backgroundColor = const Color(0xffF5F4F6);

  ThemeData theme = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: const Color(0xffF5F4F6),
      primaryColor: const Color(0xff1E2A5E),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff1E2A5E),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Color(0xffF5F4F6),
      ));
}
