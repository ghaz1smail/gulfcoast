import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/admin_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/view/admin/cars/car_widget.dart';
import 'package:gulfcoast/view/admin/cars/add_car_dialog.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';

class AdminCars extends StatefulWidget {
  const AdminCars({super.key});

  @override
  State<AdminCars> createState() => _AdminCarsState();
}

class _AdminCarsState extends State<AdminCars> {
  final ScrollController scrollViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    adminController.fetchCars();
    scrollViewController.addListener(loadMoreData);
  }

  loadMoreData() {
    if (adminController.hasMoreCars) {
      double currentPosition = scrollViewController.position.pixels;
      double maxExtent = scrollViewController.position.maxScrollExtent;
      const double threshold = 0.25;
      if (currentPosition >= maxExtent * threshold) {
        adminController.fetchMoreCars();
      }
    }
  }

  @override
  void dispose() {
    scrollViewController.dispose();
    scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AdminController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchMoreCars();
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
                  child: (controller.searchCarController.text.isEmpty
                          ? controller.cars == null
                          : controller.searchCars == null)
                      ? const CustomLoading()
                      : (controller.searchCarController.text.isEmpty
                              ? controller.cars!.isEmpty
                              : controller.searchCars!.isEmpty)
                          ? Center(child: Text('no_data_found'.tr))
                          : ListView.builder(
                              shrinkWrap: true,
                              controller: scrollViewController,
                              itemCount:
                                  controller.searchCarController.text.isEmpty
                                      ? controller.cars?.length
                                      : controller.searchCars?.length,
                              itemBuilder: (context, index) {
                                CarModel car =
                                    controller.searchCarController.text.isEmpty
                                        ? controller.cars![index]
                                        : controller.searchCars![index];
                                return CarWidget(carData: car);
                              },
                            ),
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
