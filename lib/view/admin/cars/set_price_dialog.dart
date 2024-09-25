import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/admin_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';

class SetPriceBottomSheet extends StatelessWidget {
  final String vin;
  final Function updatingData;
  const SetPriceBottomSheet(
      {super.key, required this.vin, required this.updatingData});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 500;
    return SizedBox(
        height: 300,
        width: isMobile ? Get.width : 300,
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
                    hint: 'enter_price',
                    length: 17,
                    type: TextInputType.number,
                    controller: controller.price,
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
                      controller.setPrice(vin);
                      updatingData();
                    },
                    width: 200,
                    loading: controller.settingPrice,
                    color: appTheme.primaryColor)
              ],
            );
          },
        ));
  }
}
