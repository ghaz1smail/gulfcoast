import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/user_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/view/widgets/car_widget.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class AuctionCars extends StatelessWidget {
  final bool guest;
  const AuctionCars({super.key, this.guest = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guest
          ? AppBar(
              title: Text(
                'car_for_sale'.tr,
                style: const TextStyle(color: Colors.black),
              ),
              leading: const IconBack(),
            )
          : null,
      body: GetBuilder(
        init: UserController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.updateUI();
            },
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Flexible(
                          child: CupertinoSearchTextField(
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/filter');
                          },
                          child: const Icon(Icons.filter_alt),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: PaginateFirestore(
                    onEmpty: SizedBox(
                      height: Get.height * 0.75,
                      child: Center(
                          child: Text(
                        'no_data_found'.tr,
                      )),
                    ),
                    initialLoader: SizedBox(
                        height: Get.height * 0.75,
                        child: const CustomLoading()),
                    itemBuilder: (context, documentSnapshots, index) {
                      CarModel car = CarModel.fromJson(
                          documentSnapshots[index].data() as Map);
                      return CarWidget(carData: car);
                    },
                    query: firestore
                        .collection('cars')
                        .where('userId', isNull: true),
                    itemBuilderType: PaginateBuilderType.listView,
                    isLive: true,
                  )

                      //  (controller.searchCarController.text.isEmpty
                      //         ? controller.cars == null
                      //         : controller.searchCars == null)
                      //     ? const CustomLoading()
                      //     : (controller.searchCarController.text.isEmpty
                      //             ? controller.cars!.isEmpty
                      //             : controller.searchCars!.isEmpty)
                      //         ? Center(child: Text('no_data_found'.tr))
                      //         : ListView.builder(
                      //             shrinkWrap: true,
                      //             controller: scrollViewController,
                      //             itemCount:
                      //                 controller.searchCarController.text.isEmpty
                      //                     ? controller.cars?.length
                      //                     : controller.searchCars?.length,
                      //             itemBuilder: (context, index) {
                      //               CarModel car =
                      //                   controller.searchCarController.text.isEmpty
                      //                       ? controller.cars![index]
                      //                       : controller.searchCars![index];
                      //               return CarWidget(carData: car);
                      //             },
                      //           ),
                      )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
