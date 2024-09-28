import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconBack(),
        title: Text(
          'add_new_user'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: key,
            child: ListView(
              children: [
                CustomTextField(
                  hint: 'name',
                  controller: adminController.userName,
                  onChange: (x) {
                    adminController.changeNameText(x);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hint: 'username',
                  controller: adminController.userUsername,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hint: 'password',
                  controller: adminController.userPassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hint: 'company',
                  controller: adminController.userCompany,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hint: 'phone',
                  type: TextInputType.phone,
                  controller: adminController.userPhone,
                ),
                const SizedBox(
                  height: 25,
                ),
                Obx(
                  () => CustomButton(
                      title: 'submit',
                      function: () {
                        adminController.addNewUser();
                      },
                      width: Get.width,
                      loading: adminController.addingUser.value,
                      color: appTheme.primaryColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => adminController.checkName.value.isEmpty
                      ? const SizedBox()
                      : CustomButton(
                          title: 'generate_data_from_name',
                          function: () {
                            adminController.generateDataFromName();
                          },
                          width: 100,
                          loading: adminController.generatingUserData.value,
                          color: appTheme.primaryColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
