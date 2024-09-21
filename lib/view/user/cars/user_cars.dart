import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/user_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/view/widgets/car_widget.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class UserCars extends StatelessWidget {
  const UserCars({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserController(),
      builder: (controller) {
        DocumentReference userRef =
            firestore.collection('users').doc(authController.userData!.uid);
        return RefreshIndicator(
          onRefresh: () async {
            controller.updateUI();
          },
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CupertinoSearchTextField(
                    onChanged: (value) {},
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
                  query: firestore
                      .collection('cars')
                      .where('userId', isEqualTo: userRef),
                  itemBuilderType: PaginateBuilderType.listView,
                  isLive: true,
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
