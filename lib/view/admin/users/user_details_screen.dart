import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/cars/car_details_screen.dart';
import 'package:gulfcoast/view/admin/users/bottom_sheet_cars.dart';
import 'package:gulfcoast/view/widgets/custom_chip.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserModel userData;
  const UserDetailsScreen({super.key, required this.userData});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserModel? userData;
  bool loading = true;

  Future<List<CarModel>> fetchReferencesData() async {
    List<DocumentReference> cars =
        userData!.cars!.map((m) => m as DocumentReference).toList();

    List<CarModel> referenceData = [];

    for (DocumentReference ref in cars) {
      final doc = await ref.get();
      referenceData.add(CarModel.fromJson(doc.data() as Map));
    }

    return referenceData;
  }

  getUserData() async {
    userData = await authController.getUserData(widget.userData.uid);
    setState(() {});
  }

  @override
  void initState() {
    userData = widget.userData;
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const IconBack(),
          title: Text(
            userData!.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomChip(
                  title: '${'username'.tr}: ${userData!.username}',
                  textToCopy: userData!.username),
              const SizedBox(
                height: 15,
              ),
              CustomChip(
                  title:
                      '${'password'.tr}: ${adminController.dectyptText(userData!.password, 'gulfPasswordCoast')}',
                  textToCopy: adminController.dectyptText(
                      userData!.password, 'gulfPasswordCoast')),
              const Divider(
                thickness: 2,
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'cars'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  InkWell(
                    onTap: () async {
                      ScrollController customScrollController =
                          ScrollController();

                      await customUi.dragAbleBottomSheet(
                          BottomSheetCars(
                            userData: userData!,
                            customScrollController: customScrollController,
                          ),
                          customScrollController);
                      await getUserData();
                    },
                    child: Icon(
                      Icons.add,
                      color: appTheme.primaryColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: userData!.cars!.isEmpty
                      ? Center(child: Text('no_data_found'.tr))
                      : RefreshIndicator(
                          onRefresh: () async {
                            await getUserData();
                          },
                          child: FutureBuilder(
                            future: fetchReferencesData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<CarModel> cars = snapshot.data!;

                                if (cars.isEmpty) {
                                  return Center(
                                      child: Text('no_data_found'.tr));
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cars.length,
                                  itemBuilder: (context, index) {
                                    CarModel car = cars[index];
                                    return Card(
                                        child: ListTile(
                                      onTap: () {
                                        Get.to(() =>
                                            CarDetailsScreen(carData: car));
                                      },
                                      title: Text(
                                          '${car.make} ${car.model} ${car.modelYear}'),
                                      trailing:
                                          Chip(label: Text(car.status.tr)),
                                    ));
                                  },
                                );
                              }

                              return const Center(
                                child: CustomLoading(),
                              );
                            },
                          ),
                        ))
            ],
          ),
        ));
  }
}
