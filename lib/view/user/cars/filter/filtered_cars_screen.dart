import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/user_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/view/widgets/car_widget.dart';
import 'package:gulfcoast/view/widgets/custom_chip.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

var query = firestore.collection('cars').where('userId', isNull: true);

class FilteredCarsScreen extends StatelessWidget {
  final String year, make, model;
  const FilteredCarsScreen(
      {super.key, this.year = '', this.make = '', this.model = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'car_for_sale'.tr,
          style: const TextStyle(color: Colors.black),
        ),
        leading: const IconBack(),
      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (year.isNotEmpty)
                        CustomChip(
                          title: year,
                          fontSize: 14,
                        ),
                      if (make.isNotEmpty)
                        CustomChip(
                          title: make,
                          fontSize: 14,
                        ),
                      if (model.isNotEmpty)
                        CustomChip(
                          title: model,
                          fontSize: 14,
                        )
                    ],
                  ),
                  const Divider(),
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
                    query: (year.isEmpty)
                        ? (make.isEmpty)
                            ? (model.isEmpty)
                                ? query
                                : query.where('model', isEqualTo: model)
                            : (model.isEmpty)
                                ? query.where('make', isEqualTo: make)
                                : query
                                    .where('make', isEqualTo: make)
                                    .where('model', isEqualTo: model)
                        : (make.isEmpty)
                            ? (model.isEmpty)
                                ? query.where('model_year', isEqualTo: year)
                                : query
                                    .where('model_year', isEqualTo: year)
                                    .where('model', isEqualTo: model)
                            : (model.isEmpty)
                                ? query
                                    .where('model_year', isEqualTo: year)
                                    .where('make', isEqualTo: make)
                                : query
                                    .where('model_year', isEqualTo: year)
                                    .where('make', isEqualTo: make)
                                    .where('model', isEqualTo: model),
                    itemBuilderType: PaginateBuilderType.listView,
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
