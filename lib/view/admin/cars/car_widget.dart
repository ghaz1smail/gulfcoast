import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/view/admin/cars/car_details_screen.dart';
import 'package:gulfcoast/view/widgets/cached_network_image.dart';

class CarWidget extends StatelessWidget {
  final CarModel carData;
  const CarWidget({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CarDetailsScreen(carData: carData));
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
                          width: 125.w,
                          height: 100.w,
                          boxFit: BoxFit.fill),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: [
                              Icon(adminController.iconsSwitch(carData.status)),
                              Text(carData.status.tr),
                            ],
                          ),
                        ),
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
