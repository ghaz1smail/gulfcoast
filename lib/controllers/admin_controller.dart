import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptlib_2_0/cryptlib_2_0.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:http/http.dart' as http;

class AdminController extends GetxController {
  GetStorage getStorage = GetStorage();
  RxInt selectedIndex = 0.obs;
  List<UserModel>? searchUsers;
  bool checking = true, addingCar = false, settingPrice = false;
  RxBool addingUser = false.obs,
      generatingUserData = false.obs,
      assigning = false.obs;
  String showError = '';
  RxString checkName = ''.obs;
  TextEditingController searchCarController = TextEditingController(),
      searchUserController = TextEditingController(),
      vin = TextEditingController(),
      price = TextEditingController(),
      userName = TextEditingController(),
      userUsername = TextEditingController(),
      userCompany = TextEditingController(),
      userPhone = TextEditingController(),
      userPassword = TextEditingController();
  final url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${appData.apiKey}';

  setPrice(entredVin) async {
    settingPrice = true;
    update();
    await firestore
        .collection('cars')
        .doc(entredVin)
        .update({'price': price.text});
    Get.back();
  }

  assignUserToCar(CarModel car, UserModel user) async {
    assigning.value = true;
    update();

    DocumentReference carDoc = firestore.collection('cars').doc(car.vin);
    DocumentReference userDoc = firestore.collection('users').doc(user.uid);

    await carDoc.update({'userId': userDoc});
    await userDoc.update({
      'cars': FieldValue.arrayUnion([carDoc])
    });
    assigning.value = false;
    Get.back();
    Get.back();
  }

  changeNameText(String newName) {
    checkName.value = newName;
    update();
  }

  IconData iconsSwitch(String status) {
    switch (status) {
      case 'new':
        return Icons.check;
      case 'at_terminal':
        return Icons.check;
      case 'booked':
        return Icons.check;
      case 'loaded':
        return Icons.check;
      case 'shipped':
        return Icons.check;
      case 'delivered':
        return Icons.check;
      case 'released_to_client':
        return Icons.check;
      case 'unloaded':
        return Icons.check;
    }
    return Icons.check;
  }

  String dectyptText(String theText, String key) {
    return CryptLib.instance.decryptCipherTextWithRandomIV(theText, key);
  }

  String encryptText(String theText, String key) {
    return CryptLib.instance.encryptPlainTextWithRandomIV(theText, key);
  }

  generateDataFromName() async {
    String password = '', username = '';
    generatingUserData.value = true;
    update();
    username = userName.text.trim().toLowerCase();
    if (userName.text.length < 6) {
      password = userName.text.toLowerCase() +
          List.generate(6 - userName.text.length, (index) => index + 1).join();
    } else {
      password = userName.text.toLowerCase();
    }

    var done = false, i = 0;

    while (!done) {
      await firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((users) {
        if (users.size > 0) {
          i++;
          username = username + i.toString();
        } else {
          done = true;
          userUsername.text = username;
          userPassword.text = password;
        }
      });
    }
    generatingUserData.value = false;
    update();
  }

  addNewUser() async {
    if (userName.text.isEmpty ||
        userUsername.text.isEmpty ||
        userPhone.text.isEmpty ||
        userCompany.text.isEmpty ||
        userPassword.text.length < 6) {
      customUi.alertDialog(
        'error_occured',
        'please_fill_all_fields',
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

    addingUser.value = true;
    update();
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': '${userUsername.text.trim()}@gulfcoast.com',
        'password': userPassword.text,
        'returnSecureToken': true,
      }),
    );
    final responseData = json.decode(response.body);
    Get.log("body: $responseData");
    if (response.statusCode == 200) {
      var pass = encryptText(userPassword.text, "gulfPasswordCoast");
      await firestore.collection('users').doc(responseData['localId']).set({
        'username': userUsername.text,
        'email': '${userUsername.text.trim()}@gulfcoast.com',
        'type': 'user',
        'phone': userPhone.text,
        'company': userCompany.text,
        'uid': responseData['localId'],
        'name': userName.text,
        'tags': generateNameTag(userName.text),
        'password': pass,
        'timestamp': DateTime.now().toIso8601String(),
      });

      clearData();
      customUi.showToastMessage('user_added');
    } else {
      Get.log("Error: ${responseData['error']['message']}");

      if (responseData['error']['message'] == 'EMAIL_EXISTS') {
        customUi.showToastMessage('username_already_exist');
      } else {
        customUi.showToastMessage('something_went_wrong');
      }
    }
    addingUser.value = false;
    update();
  }

  clearData() {
    userName.clear();
    userUsername.clear();
    userPassword.clear();
    userCompany.clear();
    userPhone.clear();
    checkName.value = '';
    vin.clear();
    price.clear();
    showError = '';
    addingCar = false;
    settingPrice = false;
  }

  updateUI() {
    update();
  }

  fetchSearchUsers() async {
    final querySnapshot = await firestore.collection('users').where('tags',
        arrayContainsAny: [
          searchCarController.text.removeAllWhitespace.toLowerCase()
        ]).get();

    if (querySnapshot.docs.isNotEmpty) {
      searchUsers = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } else {
      searchUsers = [];
    }
    update();
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

      Get.offAllNamed('/register');
    }
  }

  List<String> generateCarTag(CarModel carData) {
    List<String> tags = [];
    for (int i = 1; i <= carData.vin.length; i++) {
      tags.add(carData.vin.substring(0, i).toUpperCase());
    }
    for (int i = 1; i <= carData.model.length; i++) {
      tags.add(carData.model.substring(0, i).toUpperCase());
    }
    for (int i = 1; i <= carData.make.length; i++) {
      tags.add(carData.make.substring(0, i).toUpperCase());
    }

    return tags;
  }

  List<String> generateNameTag(String name) {
    List<String> tags = [];
    for (int i = 1; i <= name.length; i++) {
      tags.add(name.substring(0, i).toUpperCase());
    }

    return tags;
  }

  updateCarFilter(CarModel carData) {
    DocumentReference ref = firestore.collection('cars').doc(carData.vin);
    firestore.collection('makers').doc(carData.make.toUpperCase()).set({
      'cars': FieldValue.arrayUnion([ref]),
      'title': carData.make.toUpperCase()
    }, SetOptions(merge: true));

    firestore.collection('models').doc(carData.model.toUpperCase()).set({
      'cars': FieldValue.arrayUnion([ref]),
      'title': carData.model.toUpperCase(),
      'maker': carData.make.toUpperCase()
    }, SetOptions(merge: true));
  }

  addCar(String enteredVin) async {
    enteredVin = enteredVin.toUpperCase();
    if (adminController.vin.text.length < 17) {
      showError = 'vin_should_at_least_17_characters';
      update();
      return;
    }
    addingCar = true;
    update();
    await firestore.collection('cars').doc(enteredVin).get().then((t) async {
      if (t.exists) {
        showError = 'the_car_is_already_exists';
      } else {
        CarModel? carData = await getCarData(enteredVin);
        if (carData == null) {
          showError = 'no_data_found';
        } else {
          showError = '';
          await firestore.collection('cars').doc(enteredVin).set({
            'timestamp': DateTime.now().toIso8601String(),
            'tags': generateCarTag(carData),
            ...carData.toJson()
          }, SetOptions(merge: true));
          vin.clear();
          updateCarFilter(carData);
        }
      }
    });

    addingCar = false;
    update();
  }

  Future<CarModel?> getCarData(String vin) async {
    CarModel? checkCar;
    try {
      var headers = {'x-AuthKey': 'bc49ab6716d44747b7765a9729564a84'};
      var request = http.Request(
          'GET', Uri.parse('https://api.vehicledatabases.com/auction/$vin'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      Get.log('doneResponse');
      String data = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Get.log('doneDataBase');
        checkCar = VehicleData.fromJson(jsonDecode(data), true).carData;
        return checkCar;
      } else {
        Get.log('mmm');
        var headers = {
          'x-rapidapi-host': 'car-utils.p.rapidapi.com',
          'x-rapidapi-key': 'cddfad3d30msh687ccf59d2e11a3p16c8e5jsnc4b8c97f25e2'
        };
        var requestData = http.Request('GET',
            Uri.parse('https://car-utils.p.rapidapi.com/vindecoder?vin=$vin'));

        requestData.headers.addAll(headers);

        http.StreamedResponse responseData = await requestData.send();
        String data = await responseData.stream.bytesToString();
        Get.log('DoneResponsemmmm');
        if (responseData.statusCode == 200) {
          Get.log('DoneDatammmm');
          var r = VehicleData.fromJson(jsonDecode(data), false);
          if (r.errors!.first.toString().startsWith('0')) {
            checkCar = r.carData;
            checkCar!.vin = vin;
            return checkCar;
          } else {
            customUi.showToastMessage(
                'something_went_wrong_try_again_later_or_try_another_vin');
            return null;
          }
        } else {
          return null;
        }
      }
    } catch (e) {
      Get.log('Error: $e');
      customUi.showToastMessage(
          'something_went_wrong_try_again_later_or_try_another_vin');
    }
    return null;
  }
}
