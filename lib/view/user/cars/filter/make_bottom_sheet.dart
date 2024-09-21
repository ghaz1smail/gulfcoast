import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/cars/select_car_dialog.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class BottomSheetUsers extends StatelessWidget {
  final ScrollController customScrollController;
  final CarModel carData;

  const BottomSheetUsers(
      {super.key, required this.customScrollController, required this.carData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(10),
        //   child: CupertinoSearchTextField(
        //     onChanged: (value) {},
        //     controller: adminController.searchCarController,
        //   ),
        // ),

        Expanded(
            child: PaginateFirestore(
          scrollController: customScrollController,
          onEmpty: SizedBox(
            height: Get.height * 0.9,
            child: Center(
                child: Text(
              'no_data_found'.tr,
            )),
          ),
          initialLoader:
              SizedBox(height: Get.height * 0.9, child: const CustomLoading()),
          itemBuilder: (context, documentSnapshots, index) {
            UserModel selectedUser =
                UserModel.fromJson(documentSnapshots[index].data() as Map);
            return Card(
              child: ListTile(
                onTap: () {
                  customUi.customDialog(
                      SelectUserDialog(
                        carData: carData,
                        userData: selectedUser,
                      ),
                      dissmiss: false);
                },
                title: Text(selectedUser.name),
              ),
            );
          },
          query: firestore.collection('users').where('type', isEqualTo: 'user'),
          itemBuilderType: PaginateBuilderType.listView,
        ))
      ],
    );
  }
}
