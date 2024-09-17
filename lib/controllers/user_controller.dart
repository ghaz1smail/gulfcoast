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
    var uid = getStorage.read('uid');
    Get.log(uid.toString());
    if (uid != null) {
      await authController.getCurrentUserData();

      if (authController.userData!.type == 'admin') {
        Get.offAllNamed('/admin');
      } else {
        checking = false;
        update();
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 100));

      Get.offAllNamed('/');
    }
  }
}
