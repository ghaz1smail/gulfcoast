import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

class AdminController extends GetxController {
  var getStorage = GetStorage();
  RxInt selectedIndex = 0.obs;
  bool checking = true;

  RxBool addingCar = false.obs;
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

  addCar(vin) async {
    addingCar.value = true;
    update();
    CarModel? carData = await getCarData(vin);
    if (carData == null) {
      Get.log('no data');
    } else {
      Get.log(carData.toJson().toString());
      Get.log('done');
    }
    addingCar.value = false;
    update();
  }

  Future<CarModel?> getCarData(vin) async {
    var headers = {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      'Accept': '*/*',
      'Cookie':
          'PHPSESSID=s47hhuls8icsq6aacgpelblvd4; currency=USD; default=eahcc6hsnckmkr99e77pdt5ps1; language=ru-ru',
    };

    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://cars.autotorgby.com/istoriya-prodazh-copart-iaai-manheim?VIN=$vin'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var body = await response.stream.bytesToString();

        var document = parse(body);

        var rows = document.querySelectorAll('table tbody tr');

        Map<String, String> vehicleData = {};

        for (var row in rows) {
          var cells = row.querySelectorAll('td');
          if (cells.length == 2) {
            String key = cells[0].text.trim();
            String value = cells[1].text.trim();
            vehicleData[key] = value;
          }
        }

        // Get.log(vehicleData.toString());
        CarModel carData = CarModel.fromJson(vehicleData)
          ..images = getImages(body);
        return carData;
      } else {
        Get.log('reasonPhrase: :${response.reasonPhrase}');
      }
    } catch (e) {
      Get.log('error: :$e');
    }
    return null;
  }

  List<String> getImages(htmlContent) {
    List<String> images = [];
    dom.Document document = parse(htmlContent);
    List<dom.Element> linkElements = document.getElementsByTagName('link');

    for (var element in linkElements) {
      if (element.attributes['itemprop'] == 'contentUrl') {
        images.add(element.attributes['href'] ?? '');
      }
    }
    return images;
  }
}
