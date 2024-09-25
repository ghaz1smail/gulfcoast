import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconBack extends StatelessWidget {
  final Color color;
  final Function? onPressed;
  const IconBack({super.key, this.color = Colors.black, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.closeAllSnackbars();
          if (onPressed == null) {
            Get.back();
          } else {
            onPressed!();
          }
        },
        icon: Icon(
          Icons.arrow_back,
          color: color,
        ));
  }
}
