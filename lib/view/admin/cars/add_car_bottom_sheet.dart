import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/admin_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';

class AddCarBottomSheet extends StatelessWidget {
  const AddCarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: GetBuilder(
          dispose: (s) {
            adminController.clearData();
          },
          init: AdminController(),
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hint: 'enter_vin',
                    length: 17,
                    controller: controller.vin,
                  ),
                ),
                if (controller.showError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      controller.showError.tr,
                      style: const TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 25),
                CustomButton(
                    title: 'submit',
                    function: () async {
                      await controller.addCar(controller.vin.text);
                    },
                    width: 200,
                    loading: controller.addingCar,
                    color: appTheme.primaryColor)
              ],
            );
          },
        ));
  }
}
