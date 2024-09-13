import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  customDialog(String title, String content, Map leftB, Map rightB) {
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
          TextButton(onPressed: leftB['function'], child: Text(leftB['title'])),
        if (rightB.isNotEmpty)
          TextButton(
              onPressed: rightB['function'], child: Text(rightB['title'])),
      ],
    );
  }
}
