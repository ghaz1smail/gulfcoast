import 'package:flutter/material.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.size = 100});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: appTheme.primaryColor,
    ));
  }
}
