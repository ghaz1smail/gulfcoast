import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/user/cars/filter/filtered_cars_screen.dart';
import 'package:gulfcoast/view/user/cars/filter/filter_bottom_sheet.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String year = '', make = '', model = '';
  DateTime selectedYear = DateTime.now();

  selectYear() async {
    Get.defaultDialog(
      title: "select_year".tr,
      content: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: 300,
        height: 300,
        child: YearPicker(
          firstDate: DateTime(1950),
          lastDate: DateTime(DateTime.now().year + 1),
          selectedDate: selectedYear,
          currentDate: selectedYear,
          onChanged: (DateTime dateTime) {
            selectedYear = dateTime;
            year = dateTime.year.toString();
            setState(() {});
            Get.back();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'filter'.tr,
          style: const TextStyle(color: Colors.black),
        ),
        leading: const IconBack(),
      ),
      body: Column(
        children: [
          Card(
              child: ListTile(
            onTap: () {
              selectYear();
            },
            title: Text('year'.tr),
            trailing: Text(year.isEmpty ? 'select'.tr : year),
          )),
          Card(
              child: ListTile(
            onTap: () {
              ScrollController customScrollController = ScrollController();
              customUi.dragAbleBottomSheet(
                  FilterBottomSheet(
                    customScrollController: customScrollController,
                    onTap: (x) {
                      setState(() {
                        make = x;
                      });
                      Get.back();
                    },
                  ),
                  customScrollController);
            },
            title: Text('make'.tr),
            trailing: Text(make.isEmpty ? 'select'.tr : make),
          )),
          Card(
              child: ListTile(
            enabled: make.isNotEmpty,
            onTap: () {
              ScrollController customScrollController = ScrollController();
              customUi.dragAbleBottomSheet(
                  FilterBottomSheet(
                    maker: make,
                    customScrollController: customScrollController,
                    onTap: (x) {
                      setState(() {
                        model = x;
                      });
                      Get.back();
                    },
                  ),
                  customScrollController);
            },
            title: Text('model'.tr),
            trailing: Text(model.isEmpty ? 'select'.tr : model),
          )),
          const SizedBox(
            height: 25,
          ),
          CustomButton(
              title: 'search',
              function: () {
                Get.to(() => FilteredCarsScreen(
                      year: year,
                      make: make,
                      model: model,
                    ));
              },
              width: 200,
              color: appTheme.primaryColor)
        ],
      ),
    );
  }
}
