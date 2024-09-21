import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  var getStorage = GetStorage();
  bool checking = true;

  updateUI() {
    update();
  }
}
