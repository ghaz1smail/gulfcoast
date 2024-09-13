import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/auth_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_scroll_bar.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      init: AuthController(),
      builder: (controller) {
        return CustomScrollBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutofillGroup(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(35),
                  decoration: isMobile
                      ? null
                      : BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(12),
                        ),
                  width: isMobile ? null : 500,
                  height: isMobile ? null : 600,
                  child: Column(
                    children: [
                      Image.asset(assets.logo, height: 100, width: 100),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        hint: 'email',
                        controller: controller.emailController,
                        autofill: const [AutofillHints.email],
                        onSubmit: (w) {
                          controller.forgetingPassAuth();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomButton(
                          loading: controller.loading,
                          title: 'reset_password',
                          function: () async {
                            controller.forgetingPassAuth();
                          },
                          color: appTheme.primaryColor,
                          raduis: 10,
                          size: 17,
                          width: Get.width,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.offAllNamed('/');
                        },
                        child: Text(
                          'back'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: appTheme.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
