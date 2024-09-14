import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/app_model.dart';
import 'package:gulfcoast/models/user_model.dart';

class AuthController extends GetxController {
  var getStorage = GetStorage();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  UserModel? userData;
  bool loading = false, admin = false, signIn = true, checking = true;
  AppModel appData = AppModel();

  @override
  void onInit() {
    checkUserAvailable();
    super.onInit();
  }

  checkUserAvailable({bool goHome = true}) async {
    await getCurrentUserData();

    if (userData != null) {
      if (goHome) {
        if (userData!.type == 'admin') {
          Get.offAllNamed('/admin');
        } else {
          Get.offAllNamed('/home');
        }
      }
    }
    await Future.delayed(const Duration(milliseconds: 50));
    checking = false;
    update();
  }

  Future<UserModel?> getUserData(uid) async {
    await firestore.collection('users').doc(uid).get().then((value) {
      if (value.exists) {
        return UserModel.fromJson(value.data() as Map);
      } else {
        return null;
      }
    });
    return null;
  }

  changeMode() {
    signIn = !signIn;
    update();
  }

  forgetingPassAuth() async {
    if (!emailController.text.contains('@')) {
      customDialog.customDialog(
        'error_occured'.tr,
        'please_enter_a_valid_email'.tr,
        {},
        {
          'title': 'ok'.tr,
          'function': () {
            Get.back();
          }
        },
      );
      return;
    }
    setLoading(true);

    try {
      await firebaseAuth.sendPasswordResetEmail(
        email: emailController.text,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          customDialog.customDialog(
            'alreadyHave'.tr,
            'this_email_address_is_associated_with_an_existing_account'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
        case 'too-many-requests':
          customDialog.customDialog(
            'too_many_requests'.tr,
            'try_again_later'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;

        default:
          customDialog.customDialog(
            'error_occured'.tr,
            e.message.toString(),
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
      }
    }

    setLoading(false);
  }

  logOut() async {
    admin = false;
    userData = null;
    getStorage.remove('uid');
    if (firebaseAuth.currentUser != null) {
      firebaseAuth.signOut();
    }
    Get.offAllNamed('/');
  }

  clearData() async {
    emailController.clear();
    passwordController.clear();
  }

  getCurrentUserData() async {
    var uid = getStorage.read('uid');
    if (uid != null) {
      await firestore.collection('users').doc(uid).get().then((value) async {
        if (value.exists) {
          userData = UserModel.fromJson(value.data() as Map);
        } else {
          await logOut();
        }
      });
    }
  }

  navigator() async {
    await getCurrentUserData();
    if (userData == null) {
      Get.offAllNamed('/');
    } else {
      if (userData!.type == 'admin') {
        admin = true;
        Get.offAllNamed('/admin');
      } else {
        Get.offAllNamed('/home');
      }
    }
    clearData();
  }

  Future<String> checkUserName(String username) async {
    String theUsername = '';

    while (theUsername.isEmpty) {
      await firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((users) {
        if (users.docs.isEmpty) {
          theUsername = username;
        } else {
          // username =
          //     (fNameController.text.trim() + users.docs.length.toString());
        }
      });
    }
    return theUsername;
  }

  createUser() async {
    getStorage.write('uid', firebaseAuth.currentUser!.uid);
    userData = UserModel(
      username: '',
      uid: firebaseAuth.currentUser!.uid,
      timestamp: DateTime.now().toIso8601String(),
      email: '',
      firstName: '',
      userUsingCode: [],
      type: 'user',
    )
      ..password = customFormats.encryptText(passwordController.text, "pass")
      ..tags = customFormats.generateTagsCustom('');
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(userData!.toJson());
  }

  signingInAuth() async {
    if (emailController.text.isEmpty) {
      customDialog.customDialog(
        'error_occured'.tr,
        'please_enter_a_valid_username'.tr,
        {},
        {
          'title': 'ok'.tr,
          'function': () {
            Get.back();
          }
        },
      );
      return;
    }

    if (passwordController.text.length < 6) {
      customDialog.customDialog(
        'error_occured'.tr,
        'password_length_should_at_least_6_character'.tr,
        {},
        {
          'title': 'ok'.tr,
          'function': () {
            Get.back();
          }
        },
      );
      return;
    }
    setLoading(true);
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: '${emailController.text.trim()}@gulfcoast.com',
          password: passwordController.text);
      getStorage.write('uid', firebaseAuth.currentUser!.uid);
      await navigator();
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      switch (e.code) {
        case 'wrong-password':
          customDialog.customDialog(
            'something_went_wrong'.tr,
            'incorrect_password'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
        case 'user-not-found' || 'invalid-email':
          customDialog
              .customDialog('error_occured'.tr, 'your_account_not_found'.tr, {
            'title': 'try_again'.tr,
            'function': () {
              Get.back();
            }
          }, {});
          break;
        case 'too-many-requests':
          customDialog.customDialog(
            'too_many_requests'.tr,
            'try_again_later'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
        default:
          customDialog.customDialog(
            'error_occured'.tr,
            e.message.toString(),
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
      }
    } finally {
      setLoading(false);
    }
  }

  setLoading(x) {
    loading = x;
    update();
  }
}
