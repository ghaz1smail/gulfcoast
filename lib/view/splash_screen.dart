import 'package:flutter/material.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authController.checkUserAvailable();
    return Scaffold(
      body: Center(
        child: Lottie.asset(appAssets.splash),
      ),
    );
  }
}
