import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/car_model.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/cars/bottom_sheet_user.dart';
import 'package:gulfcoast/view/admin/cars/set_price_dialog.dart';
import 'package:gulfcoast/view/admin/users/user_details_screen.dart';
import 'package:gulfcoast/view/widgets/cached_network_image.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_chip.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:gulfcoast/view/widgets/full_screen.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class CarDetailsScreen extends StatefulWidget {
  final CarModel carData;
  const CarDetailsScreen({super.key, required this.carData});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  CarModel? carData;
  bool loading = false;
  XFile? attachFile;
  String imageUrl = '';

  getCarData() async {
    setState(() {
      loading = true;
    });
    await firestore
        .collection('cars')
        .doc(widget.carData.vin)
        .get()
        .then((value) {
      if (value.exists) {
        carData = CarModel.fromJson(value.data() as Map);
      }
    });
    setState(() {
      loading = false;
    });
  }

  pickImage() async {
    final XFile? pickedImages = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedImages != null) {
      setState(() {
        loading = true;
        attachFile = pickedImages;
      });

      String filePath =
          'invoices/${carData!.vin}/${basename(attachFile!.path)}';
      final fileBytes = attachFile!.readAsBytes();
      firebaseStorage
          .ref()
          .child(filePath)
          .putData(
              await fileBytes,
              SettableMetadata(
                contentType: 'image/jpeg',
              ))
          .then((e) async {
        imageUrl = await firebaseStorage.ref().child(filePath).getDownloadURL();
        await firestore.collection('cars').doc(carData!.vin).update({
          'invoice':
              await firebaseStorage.ref().child(filePath).getDownloadURL()
        });
        setState(() {
          attachFile = null;
        });
        getCarData();
      });
    }
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
        actions: [
          if (authController.admin)
            TextButton(
                onPressed: () async {
                  adminController.price.text = carData!.price;
                  await customUi.simpleBottomSheet(SetPriceBottomSheet(
                      vin: carData!.vin, updatingData: getCarData));
                },
                child: Text(
                  'set_price'.tr,
                  style: TextStyle(color: appTheme.primaryColor),
                ))
        ],
      ),
      body: loading
          ? const CustomLoading()
          : RefreshIndicator(
              onRefresh: () async {
                await getCarData();
              },
              child: ListView(
                children: [
                  if (carData!.images!.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        Get.to(() => FullScreen(
                            urls: carData!.images!
                                .map((m) => m.toString())
                                .toList()));
                      },
                      child: SizedBox(
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
                                          updatingData: getCarData,
                                        ),
                                        customScrollController);
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
                                          Get.to(() => UserDetailsScreen(
                                              userData: user));
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
                            if (authController.userData != null)
                              Row(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Icon(adminController.iconsSwitch(
                                              widget.carData.status)),
                                          Text(
                                            carData!.status.tr,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  if (authController.admin)
                                    PopupMenuButton(
                                      itemBuilder: (context) => appData
                                          .carsStatus
                                          .map((m) => PopupMenuItem(
                                                child: Text(m.tr),
                                                onTap: () async {
                                                  await firestore
                                                      .collection('cars')
                                                      .doc(carData!.vin)
                                                      .update({'status': m});
                                                  getCarData();
                                                },
                                              ))
                                          .toList(),
                                      child: Text(
                                        'update'.tr,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: appTheme.lightColor),
                                      ),
                                    )
                                ],
                              ),
                            if (carData!.price.isNotEmpty)
                              Text(
                                '${'aed'.tr} ${carData!.price}',
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
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
                        if (carData!.fuelType.isNotEmpty)
                          CustomChip(
                              title: '${'fuel_type'.tr}: ${carData!.fuelType}'),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomChip(
                              title: '${'vin'.tr}: ${carData!.vin}',
                              textToCopy: carData!.vin,
                            )),
                        if (carData!.lotNumber.isNotEmpty)
                          CustomChip(
                              title: '${'lot'.tr}: #${carData!.lotNumber}'),
                        carData!.invoice.isEmpty
                            ? authController.admin
                                ? ListTile(
                                    onTap: () {
                                      pickImage();
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.attach_file,
                                        color: appTheme.primaryColor),
                                    title: Text('attach_invoice'.tr),
                                  )
                                : const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      FullScreen(urls: [carData!.invoice]));
                                },
                                child: ClipRRect(
                                  child: CustomImageNetwork(
                                      url: carData!.invoice,
                                      width: 200,
                                      height: 200,
                                      boxFit: BoxFit.cover),
                                ),
                              ),
                        if (authController.userData != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'destination'.tr,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (authController.admin)
                                    PopupMenuButton(
                                      child: const Icon(Icons.add),
                                      itemBuilder: (context) => authController
                                          .appData.locations!
                                          .map((m) => PopupMenuItem(
                                              onTap: () async {
                                                await firestore
                                                    .collection('cars')
                                                    .doc(carData!.vin)
                                                    .update({
                                                  'destination':
                                                      FieldValue.arrayUnion([
                                                    {
                                                      'title': m,
                                                      'timestamp':
                                                          DateTime.now()
                                                              .toIso8601String()
                                                    }
                                                  ])
                                                });
                                                getCarData();
                                              },
                                              child: Text(m.toString().tr)))
                                          .toList(),
                                    )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ...carData!.destination!.map((m) => Card(
                                    child: ListTile(
                                      title: Text(m.title.tr),
                                      trailing: Text(DateFormat('yyyy-MM-dd')
                                          .format(DateTime.parse(m.timestamp))),
                                    ),
                                  )),
                            ],
                          ),
                        if (!authController.admin && carData!.userId == null)
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 20),
                            child: CustomButton(
                                title: 'contact',
                                function: () {
                                  // launchUrl(
                                  //     Uri.parse('tel:'));
                                },
                                width: 200,
                                color: appTheme.primaryColor),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
