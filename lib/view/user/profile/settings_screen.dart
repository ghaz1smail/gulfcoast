import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const IconBack(),
          title: Text(
            'settings'.tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Obx(
          () => authController.deleting.value
              ? const CustomLoading()
              : Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.person_remove,
                        color: Colors.red,
                      ),
                      onTap: () {
                        customUi.alertDialog(
                            'are_you_sure_to_delete_your_account', '', {
                          'title': 'no'.tr,
                          'function': () {
                            Get.back();
                          }
                        }, {
                          'title': 'yes'.tr,
                          'function': () {
                            authController.deleteAccount();
                          }
                        });
                      },
                      title: Text('delete_account'.tr),
                    )
                  ],
                ),
        ));
  }
}
