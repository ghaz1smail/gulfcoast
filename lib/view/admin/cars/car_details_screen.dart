import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/cars/bottom_sheet_user.dart';
import 'package:gulfcoast/view/admin/users/user_details_screen.dart';
import 'package:gulfcoast/view/widgets/cached_network_image.dart';
import 'package:gulfcoast/view/widgets/custom_chip.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';

class CarDetailsScreen extends StatefulWidget {
  final CarModel carData;
  const CarDetailsScreen({super.key, required this.carData});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  CarModel? carData;

  getCarData() async {
    await firestore
        .collection('cars')
        .doc(widget.carData.vin)
        .get()
        .then((value) {
      if (value.exists) {
        carData = CarModel.fromJson(value.data() as Map);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    carData = widget.carData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconBack(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getCarData();
        },
        child: ListView(
          children: [
            if (carData!.images!.isNotEmpty)
              SizedBox(
                width: Get.width,
                height: 300,
                child: PageView(
                    children: carData!.images!
                        .map((m) => CustomImageNetwork(
                            url: m,
                            width: Get.width,
                            height: 300,
                            boxFit: BoxFit.fill))
                        .toList()),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (authController.admin)
                    carData!.userId == null
                        ? ListTile(
                            onTap: () async {
                              ScrollController customScrollController =
                                  ScrollController();
                              await customUi.dragAbleBottomSheet(
                                  BottomSheetUsers(
                                    carData: carData!,
                                    customScrollController:
                                        customScrollController,
                                  ),
                                  customScrollController);
                              await getCarData();
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.person,
                                color: appTheme.primaryColor),
                            title: Text('select_user_for_this_car'.tr),
                          )
                        : FutureBuilder(
                            future: carData!.userId!.get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                UserModel user = UserModel.fromJson(
                                    snapshot.data!.data() as Map);
                                return ListTile(
                                  onTap: () {
                                    Get.to(() =>
                                        UserDetailsScreen(userData: user));
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.person,
                                      color: appTheme.primaryColor),
                                  title: Text(user.name),
                                  trailing: Text(
                                    'owner'.tr,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: appTheme.primaryColor),
                                  ),
                                );
                              }

                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.person,
                                    color: appTheme.primaryColor),
                                title: Text('loading'.tr),
                                trailing: Text(
                                  'owner'.tr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: appTheme.primaryColor),
                                ),
                              );
                            },
                          ),
                  if (authController.admin)
                    const Divider(
                      thickness: 2,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: [
                              Icon(adminController
                                  .iconsSwitch(widget.carData.status)),
                              Text(
                                carData!.status.tr,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (carData!.price.isNotEmpty)
                        Text(
                          '${'aed'.tr} ${carData!.price}',
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomChip(
                      title: '${'make'.tr}: ${carData!.make}',
                      textToCopy: carData!.make,
                    ),
                  ),
                  CustomChip(
                      title: '${'model'.tr}: ${carData!.model}',
                      textToCopy: carData!.model),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomChip(
                        title: '${'year'.tr}: ${carData!.modelYear}',
                        textToCopy: carData!.modelYear),
                  ),
                  CustomChip(
                      title: '${'fuel_type'.tr}: ${carData!.fuelTypePrimary}'),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomChip(
                        title: '${'vin'.tr}: ${carData!.vin}',
                        textToCopy: carData!.vin,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
