import 'package:flutter/material.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authController.checkUserAvailable();
    return const Scaffold(
      body: CustomLoading(),
    );
  }
}
