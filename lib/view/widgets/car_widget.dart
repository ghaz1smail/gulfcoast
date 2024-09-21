import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/cars/car_details_screen.dart';
import 'package:gulfcoast/view/admin/users/select_car_dialog.dart';
import 'package:gulfcoast/view/widgets/cached_network_image.dart';

class CarWidget extends StatelessWidget {
  final CarModel carData;
  final UserModel? selectedUser;
  const CarWidget({super.key, required this.carData, this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectedUser != null) {
          customUi.customDialog(
              SelectCarDialog(
                carData: carData,
                userData: selectedUser!,
              ),
              dissmiss: false);
        } else {
          Get.to(() => CarDetailsScreen(carData: carData));
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  if (carData.images!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomImageNetwork(
                          url: carData.images?.first,
                          width: Get.width * 0.25,
                          height: Get.height * 0.1,
                          boxFit: BoxFit.fill),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 5,
                                children: [
                                  Icon(adminController
                                      .iconsSwitch(carData.status)),
                                  Text(carData.status.tr),
                                ],
                              ),
                            ),
                          ),
                          if (carData.price.isNotEmpty)
                            Text(
                              '${'aed'.tr} ${carData.price}',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${carData.make} ${carData.model} ${carData.year}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ))
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: carData.vin))
                      .then((_) {});
                },
                child: Chip(
                    label: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${'vin'.tr}: ${carData.vin}'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.copy,
                        size: 16,
                      )
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
