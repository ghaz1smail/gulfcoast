import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class UserController extends GetxController {
  var getStorage = GetStorage();
  RxInt selectedIndex = 0.obs;
  bool checking = true;

  changeSelectedIndex(String path) {
    switch (path) {
      case '/home':
        selectedIndex.value = 0;
        break;
      case '/mining-devices':
        selectedIndex.value = 1;
        break;
      case '/wallet':
        selectedIndex.value = 2;
        break;
      case '/mine':
        selectedIndex.value = 3;
        break;
      case '/contact-us':
        selectedIndex.value = 4;
        break;
      case '/profile':
        selectedIndex.value = 5;
        break;
    }
    checkUserRoute();
  }

  checkUserRoute({bool updateData = true}) async {
    checking = true;
    if (updateData) {
      update();
    }
    await Future.delayed(const Duration(milliseconds: 100));
    var uid = getStorage.read('uid');
    Get.log(uid.toString());
    if (uid != null) {
      if (authController.userData == null) {
        await authController.getCurrentUserData();
      }
      await Future.delayed(const Duration(milliseconds: 100));
      checking = false;
      update();
    } else {
      Get.offAllNamed('/');
    }
  }
}
