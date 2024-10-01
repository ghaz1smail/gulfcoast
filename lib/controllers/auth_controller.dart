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
  bool loading = false, admin = false;
  RxBool deleting = false.obs;
  AppModel appData = AppModel();

  checkUserAvailable() async {
    await getAppInfo();
    await getCurrentUserData();

    if (userData != null) {
      if (userData!.type == 'admin') {
        admin = true;
        Get.offAllNamed('/admin');
      } else {
        Get.offAllNamed('/home');
      }
    } else {
      Get.offAllNamed('/register');
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    UserModel? gettingUser;
    await firestore.collection('users').doc(uid).get().then((value) {
      if (value.exists) {
        gettingUser = UserModel.fromJson(value.data() as Map);
      }
    });
    return gettingUser;
  }

  forgetingPassAuth() async {
    if (!emailController.text.contains('@')) {
      customUi.alertDialog(
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
          customUi.alertDialog(
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
          customUi.alertDialog(
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
          customUi.alertDialog(
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
    Get.offAllNamed('/register');
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

  getAppInfo() async {
    await firestore
        .collection('appData')
        .doc('appData')
        .get()
        .then((value) async {
      appData = AppModel.fromJson(value.data() as Map);
    }).onError((e, e1) {
      return;
    });
  }

  navigator() async {
    await getCurrentUserData();
    if (userData == null) {
      Get.offAllNamed('/register');
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

  signingInAuth() async {
    if (emailController.text.isEmpty) {
      customUi.alertDialog(
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
      customUi.alertDialog(
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
          customUi.alertDialog(
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
          customUi
              .alertDialog('error_occured'.tr, 'your_account_not_found'.tr, {
            'title': 'try_again'.tr,
            'function': () {
              Get.back();
            }
          }, {});
          break;
        case 'too-many-requests':
          customUi.alertDialog(
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
          customUi.alertDialog(
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

  setLoading(bool x) {
    loading = x;
    update();
  }

  deleteAccount() async {
    deleting.value = true;
    update();
    await firestore
        .collection('users')
        .doc(userData!.uid)
        .update({'deleted': true});
    logOut();
    deleting.value = false;
  }

  fakeSignUp() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    loading = true;
    await Future.delayed(const Duration(seconds: 2));
    getStorage.write('uid', id);
    await firestore.collection('users').doc(id).set({
      'username': emailController.text,
      'email': '${emailController.text.trim()}@gulfcoast.com',
      'type': 'user',
      'phone': '',
      'company': '',
      'uid': id,
      'name': emailController.text,
      'tags': [],
      'password': '',
      'fake': true,
      'timestamp': DateTime.now().toIso8601String(),
    });
    loading = false;
    navigator();
  }
}
