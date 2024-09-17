import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';

class AddCarDialog extends StatefulWidget {
  const AddCarDialog({super.key});

  @override
  State<AddCarDialog> createState() => _AddCarDialogState();
}

class _AddCarDialogState extends State<AddCarDialog> {
  TextEditingController vin = TextEditingController();
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 500;
    return SizedBox(
      height: 300,
      width: isMobile ? Get.width : 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              hint: 'enter_vin',
              controller: vin,
            ),
          ),
          Obx(() => CustomButton(
              title: 'submit',
              function: () async {
                if (vin.text.isEmpty) {
                  return;
                }

                await adminController.addCar(vin.text);

                // await firestore.collection('cars').doc(id).set(
                //     {'id': id, 'timestamp': DateTime.now().toIso8601String()});

                // Get.back();
              },
              width: 200,
              loading: adminController.addingCar.value,
              color: appTheme.primaryColor))
        ],
      ),
    );
  }
}
