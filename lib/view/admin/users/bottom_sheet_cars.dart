import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/cars/car_widget.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class BottomSheetCars extends StatelessWidget {
  final ScrollController customScrollController;
  final UserModel userData;

  const BottomSheetCars(
      {super.key,
      required this.customScrollController,
      required this.userData});

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
            CarModel car =
                CarModel.fromJson(documentSnapshots[index].data() as Map);
            return CarWidget(
              carData: car,
              selectedUser: userData,
            );
          },
          query: firestore.collection('cars').where('userId', isNull: true),
          itemBuilderType: PaginateBuilderType.listView,
        ))
      ],
    );
  }
}
