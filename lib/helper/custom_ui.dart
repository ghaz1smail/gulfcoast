import 'package:get/get.dart';

class CustomUi {
  showToastMessage(String title) {
    Get.showSnackbar(GetSnackBar(
      message: title.tr,
    ));
  }
}
