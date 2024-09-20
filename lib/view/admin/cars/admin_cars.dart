import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/admin_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/view/admin/cars/car_widget.dart';
import 'package:gulfcoast/view/admin/cars/add_car_dialog.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class AdminCars extends StatelessWidget {
  const AdminCars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AdminController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.updateUI();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CupertinoSearchTextField(
                    onChanged: (value) {
                      controller.fetchSearchCars();
                    },
                    controller: adminController.searchCarController,
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
                      height: Get.height * 0.75, child: const CustomLoading()),
                  itemBuilder: (context, documentSnapshots, index) {
                    CarModel car = CarModel.fromJson(
                        documentSnapshots[index].data() as Map);
                    return CarWidget(carData: car);
                  },
                  query: firestore.collection('cars'),
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customUi.customDialog(const AddCarDialog());
        },
        mini: true,
        child: const Icon(Icons.drive_eta),
      ),
    );
  }
}
