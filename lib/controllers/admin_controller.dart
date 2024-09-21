import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptlib_2_0/cryptlib_2_0.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class AdminController extends GetxController {
  GetStorage getStorage = GetStorage();
  RxInt selectedIndex = 0.obs;
  List<CarModel>? searchCars;
  List<UserModel>? searchUsers;
  DocumentSnapshot? lastCar, lastUser;
  final int limit = 20;
  bool checking = true, addingCar = false;
  RxBool addingUser = false.obs,
      generatingUserData = false.obs,
      assigning = false.obs;
  String showError = '';
  RxString checkName = ''.obs;
  TextEditingController searchCarController = TextEditingController(),
      searchUserController = TextEditingController(),
      vin = TextEditingController(),
      userName = TextEditingController(),
      userUsername = TextEditingController(),
      userPassword = TextEditingController();
  final url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${appData.apiKey}';

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
        userPassword.text.length < 6) {
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
    checkName.value = '';
    vin.clear();
    showError = '';
    addingCar = false;
  }

  updateUI() {
    update();
  }

  fetchSearchCars() async {
    final querySnapshot = await firestore.collection('cars').where('tags',
        arrayContainsAny: [
          searchCarController.text.removeAllWhitespace.toLowerCase()
        ]).get();

    if (querySnapshot.docs.isNotEmpty) {
      searchCars = querySnapshot.docs
          .map((doc) => CarModel.fromJson(doc.data()))
          .toList();
    } else {
      searchCars = [];
    }
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

      Get.offAllNamed('/');
    }
  }

  List<String> generateCarTag(CarModel carData) {
    List<String> tags = [], vin = [], model = [], make = [];
    for (int i = 1; i <= carData.vin.length; i++) {
      vin.add(carData.vin.substring(0, i).toLowerCase());
    }
    for (int i = 1; i <= carData.model.length; i++) {
      model.add(carData.model.substring(0, i).toLowerCase());
    }
    for (int i = 1; i <= carData.make.length; i++) {
      make.add(carData.make.substring(0, i).toLowerCase());
    }

    tags.addAll(vin);
    tags.addAll(model);
    tags.addAll(make);
    return tags;
  }

  List<String> generateNameTag(String name) {
    List<String> tags = [];
    for (int i = 1; i <= name.length; i++) {
      tags.add(name.substring(0, i).toLowerCase());
    }

    return tags;
  }

  addCar(String enteredVin) async {
    if (adminController.vin.text.length < 17) {
      showError = 'vin_should_at_least_17_characters';
      update();
      return;
    }
    addingCar = true;
    update();
    CarModel? carData = await getCarData(enteredVin);
    if (carData == null) {
      showError = 'no_data_found';
    } else {
      showError = '';
      Get.log(carData.toJson().toString());
      await firestore.collection('cars').doc(enteredVin).set({
        'timestamp': DateTime.now().toIso8601String(),
        'tags': generateCarTag(carData),
        ...carData.toJson()
      });

      Get.back();
      updateCarFilter(carData);
    }
    addingCar = false;
    update();
  }

  updateCarFilter(CarModel carData) {
    DocumentReference ref = firestore.collection('cars').doc(carData.vin);
    firestore.collection('makers').doc(carData.make).set({
      'cars': FieldValue.arrayUnion([ref]),
      'title': carData.make
    }, SetOptions(merge: true));

    firestore.collection('models').doc(carData.model).set({
      'cars': FieldValue.arrayUnion([ref]),
      'title': carData.model
    }, SetOptions(merge: true));
  }

  Future<CarModel?> getCarData(String vin) async {
    CarModel? checkCar;
    try {
      var headers = {
        'x-rapidapi-host': 'vin-decoder7.p.rapidapi.com',
        'x-rapidapi-key': 'cddfad3d30msh687ccf59d2e11a3p16c8e5jsnc4b8c97f25e2'
      };
      var requestData = http.Request(
          'GET', Uri.parse('https://vin-decoder7.p.rapidapi.com/vin?vin=$vin'));

      requestData.headers.addAll(headers);

      http.StreamedResponse responseData = await requestData.send();
      String data = await responseData.stream.bytesToString();
      if (responseData.statusCode == 200) {
        checkCar = CarModel.fromJson(jsonDecode(data)['specifications']);
        try {
          var requestImages = http.Request(
              'GET', Uri.parse('https://en.carcheck.by/auto/$vin'));

          http.StreamedResponse responseImages = await requestImages.send();
          String htmlContent = await responseImages.stream.bytesToString();
          Get.log('$htmlContent: ${responseImages.statusCode}');
          if (responseImages.statusCode == 200) {
            checkCar.images = getCarImages(htmlContent);
          }
        } catch (e) {
          //
        }
      } else {
// {"error":"Invalid Vin"}
        return null;
      }
      return checkCar;
    } catch (e) {
      customUi.showToastMessage(
          'something_went_wrong_try_again_later_or_try_another_vin');
    }
    return null;
  }

  List<String> getCarImages(String htmlContent) {
    final document = parse(htmlContent);
    final carouselDiv = document.querySelector('#owl_big');

    if (carouselDiv != null) {
      final imgElements = carouselDiv.getElementsByTagName('img');
      return imgElements
          .map((img) => img.attributes['src'] ?? '')
          .where((w) => !w.contains('noimage'))
          .toList();
    }

    return [];
  }
}
