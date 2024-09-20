import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/cars/car_details_screen.dart';
import 'package:gulfcoast/view/widgets/custom_chip.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel userData;
  const UserDetailsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    List c = userData.cars!
        .map((m) => m.toString().split('/').last.replaceAll(')', ''))
        .toList();
    return Scaffold(
        appBar: AppBar(
          leading: const IconBack(),
          title: Text(
            userData.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomChip(
                  title: '${'username'.tr}: ${userData.username}',
                  textToCopy: userData.username),
              const SizedBox(
                height: 15,
              ),
              CustomChip(
                  title:
                      '${'password'.tr}: ${adminController.dectyptText(userData.password, 'gulfPasswordCoast')}',
                  textToCopy: adminController.dectyptText(
                      userData.password, 'gulfPasswordCoast')),
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
                    onTap: () {},
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
                  child: userData.cars!.isEmpty
                      ? Center(child: Text('no_data_found'.tr))
                      : FutureBuilder(
                          future: firestore
                              .collection('cars')
                              .where('vin', whereIn: c)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<CarModel> cars = snapshot.data!.docs
                                  .map((m) => CarModel.fromJson(m.data()))
                                  .toList();

                              if (cars.isEmpty) {
                                return Center(child: Text('no_data_found'.tr));
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: cars.length,
                                itemBuilder: (context, index) {
                                  CarModel car = cars[index];
                                  return Card(
                                      child: ListTile(
                                    onTap: () {
                                      Get.to(
                                          () => CarDetailsScreen(carData: car));
                                    },
                                    title: Text(
                                        '${car.make} ${car.model} ${car.year}'),
                                    trailing: Chip(label: Text(car.status.tr)),
                                  ));
                                },
                              );
                            }

                            return const Center(
                              child: CustomLoading(),
                            );
                          },
                        ))
            ],
          ),
        ));
  }
}
