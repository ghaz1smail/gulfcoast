import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/auth_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_scroll_bar.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: appTheme.primaryColor,
          resizeToAvoidBottomInset: false,
          body: GetBuilder(
            init: AuthController(),
            builder: (controller) {
              return Stack(
                children: [
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        appAssets.logo,
                        height: 100,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        color: appTheme.backgroundColor,
                        height: Get.height * 0.8,
                        width: Get.width,
                        child: CustomScrollBar(
                          child: AutofillGroup(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SafeArea(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sign up'.tr,
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, top: 25),
                                        child: CustomTextField(
                                          hint: 'name',
                                          controller:
                                              controller.emailController,
                                          autofill: const [AutofillHints.email],
                                          onSubmit: (w) {
                                            FocusScope.of(context).unfocus();
                                            controller.fakeSignUp();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, top: 25),
                                        child: CustomTextField(
                                          hint: 'email',
                                          controller:
                                              controller.emailController,
                                          autofill: const [AutofillHints.email],
                                          onSubmit: (w) {
                                            FocusScope.of(context).unfocus();
                                            controller.fakeSignUp();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: CustomTextField(
                                          hint: 'password',
                                          secure: true,
                                          controller:
                                              controller.passwordController,
                                          autofill: const [
                                            AutofillHints.password
                                          ],
                                          onSubmit: (w) {
                                            FocusScope.of(context).unfocus();

                                            controller.fakeSignUp();
                                          },
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25),
                                        child: CustomButton(
                                          loading: controller.loading,
                                          title: 'Sign up',
                                          function: () async {
                                            FocusScope.of(context).unfocus();
                                            controller.fakeSignUp();
                                          },
                                          color: appTheme.primaryColor,
                                          size: 20,
                                          height: 50,
                                          width: Get.width * 0.75,
                                        ),
                                      ),
                                      if (!controller.loading)
                                        Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: Get.width * 0.5,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Divider(
                                                  color: appTheme.secondory,
                                                )),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text('or'.tr),
                                                ),
                                                Expanded(
                                                    child: Divider(
                                                  color: appTheme.secondory,
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (authController.appData.showSignUp)
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                              onPressed: () async {
                                                Get.back();
                                              },
                                              child: Text(
                                                'Sign in'.tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        appTheme.primaryColor),
                                              )),
                                        ),
                                    ]),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              );
            },
          )),
    );
  }
}
