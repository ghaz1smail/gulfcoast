import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/auth_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:gulfcoast/view/widgets/custom_scroll_bar.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 500;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder(
          initState: (state) {
            authController.checkUserAvailable();
          },
          init: AuthController(),
          builder: (controller) {
            return controller.checking
                ? const CustomLoading()
                : isMobile
                    ? CustomScrollBar(
                        child: AutofillGroup(
                          child: Container(
                            padding: const EdgeInsets.all(35),
                            decoration: BoxDecoration(
                              color: appTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: isMobile ? Get.width : 500,
                            height: Get.height,
                            child: SafeArea(
                              child: Column(
                                children: [
                                  Text(
                                    'log_in'.tr,
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 25),
                                    child: CustomTextField(
                                      hint: 'email',
                                      controller: controller.emailController,
                                      autofill: const [AutofillHints.email],
                                      onSubmit: (w) {
                                        FocusScope.of(context).unfocus();

                                        controller.signingInAuth();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      hint: 'password',
                                      secure: true,
                                      controller: controller.passwordController,
                                      autofill: const [AutofillHints.password],
                                      onSubmit: (w) {
                                        FocusScope.of(context).unfocus();

                                        controller.signingInAuth();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: CustomButton(
                                      loading: controller.loading,
                                      title: 'log_in',
                                      function: () async {
                                        FocusScope.of(context).unfocus();

                                        controller.signingInAuth();
                                      },
                                      color: appTheme.primaryColor,
                                      raduis: 10,
                                      size: 20,
                                      height: 50,
                                      width: Get.width,
                                    ),
                                  ),
                                  if (!controller.loading)
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextButton(
                                          onPressed: () async {
                                            Get.offAllNamed('/fogot-password');
                                          },
                                          child: Text(
                                            'forgot_password'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: appTheme.primaryColor),
                                          )),
                                    ),
                                  Lottie.asset(assets.logIn,
                                      width: Get.width,
                                      height: Get.height * 0.25),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                              child: Lottie.asset(
                            assets.logIn,
                          )),
                          AutofillGroup(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.all(35),
                              decoration: BoxDecoration(
                                color: appTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: isMobile ? Get.width : 500,
                              height: Get.height,
                              child: Column(
                                children: [
                                  Text(
                                    'log_in'.tr,
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 25),
                                    child: CustomTextField(
                                      hint: 'email',
                                      controller: controller.emailController,
                                      autofill: const [AutofillHints.email],
                                      onSubmit: (w) {
                                        FocusScope.of(context).unfocus();

                                        controller.signingInAuth();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      hint: 'password',
                                      secure: true,
                                      controller: controller.passwordController,
                                      autofill: const [AutofillHints.password],
                                      onSubmit: (w) {
                                        controller.signingInAuth();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: CustomButton(
                                      loading: controller.loading,
                                      title: 'log_in',
                                      function: () async {
                                        FocusScope.of(context).unfocus();
                                        controller.signingInAuth();
                                      },
                                      color: appTheme.primaryColor,
                                      raduis: 10,
                                      size: 20,
                                      height: 50,
                                      width: Get.width,
                                    ),
                                  ),
                                  if (!controller.loading)
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextButton(
                                          onPressed: () async {
                                            Get.offAllNamed('/fogot-password');
                                          },
                                          child: Text(
                                            'forgot_password'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: appTheme.primaryColor),
                                          )),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
          },
        ));
  }
}
