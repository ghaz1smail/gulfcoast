import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gulfcoast/app/app_assets.dart';
import 'package:gulfcoast/app/app_data.dart';
import 'package:gulfcoast/app/app_theme.dart';
import 'package:gulfcoast/controllers/auth_controller.dart';
import 'package:gulfcoast/controllers/user_controller.dart';
import 'package:gulfcoast/helper/custom_formats.dart';
import 'package:gulfcoast/helper/firebase_options.dart';
import 'package:gulfcoast/view/widgets/custom_dialog.dart';


bool isMobile = Get.width < 475;

class GetInitial {
  initialApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(AuthController());
    Get.put(UserController());
    await GetStorage.init();
  }
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
AppData appData = AppData();
AppAssets assets = AppAssets();
AppTheme appTheme = AppTheme();
GetStorage getStorage = GetStorage();
CustomDialog customDialog = CustomDialog();
CustomFormats customFormats = CustomFormats();
AuthController authController = Get.find<AuthController>();
UserController userController = Get.find<UserController>();

Color colorCompute(color) {
  return Color(int.parse(color.toString())).computeLuminance() > 0.5
      ? Colors.black
      : Colors.white;
}
