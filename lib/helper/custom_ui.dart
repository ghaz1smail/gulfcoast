import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class CustomUi {
  showToastMessage(String title) {
    Get.showSnackbar(GetSnackBar(
      message: title.tr,
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
      borderRadius: 20,
    ));
  }

  alertDialog(String title, String content, Map leftB, Map rightB) {
    Get.defaultDialog(
      title: title.tr,
      titlePadding: const EdgeInsets.all(20),
      radius: 10,
      content: content.isEmpty
          ? const SizedBox()
          : Text(
              content.tr,
              textAlign: TextAlign.center,
            ),
      actions: [
        if (leftB.isNotEmpty)
          TextButton(
              onPressed: leftB['function'],
              child: Text(
                leftB['title'],
                style: TextStyle(color: appTheme.primaryColor),
              )),
        if (rightB.isNotEmpty)
          TextButton(
              onPressed: rightB['function'],
              child: Text(
                rightB['title'],
                style: TextStyle(color: appTheme.secondory),
              )),
      ],
    );
  }

  customDialog(Widget content) {
    Get.dialog(Dialog(child: content));
  }
}
