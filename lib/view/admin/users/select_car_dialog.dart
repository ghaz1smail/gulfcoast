import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';

class SelectCarDialog extends StatelessWidget {
  final CarModel carData;
  final UserModel userData;
  const SelectCarDialog(
      {super.key, required this.carData, required this.userData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Get.height * 0.3,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              Text(
                'are_you_sure_you_want_to_assign'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${carData.make} ${carData.model} ${carData.modelYear}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'to'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Text(
                userData.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Obx(
                () => adminController.assigning.value
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                adminController.assignUserToCar(
                                    carData, userData);
                              },
                              child: Text('yes'.tr)),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'no'.tr,
                                style: const TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
              )
            ],
          ),
        ));
  }
}
