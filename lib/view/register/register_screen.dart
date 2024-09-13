import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/auth_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:gulfcoast/view/widgets/custom_scroll_bar.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                : CustomScrollBar(
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
                            width: isMobile ? Get.width : 500,
                            height: isMobile ? Get.height : 600,
                            child: Column(
                              children: [
                                Image.asset(assets.logo,
                                    height: 100, width: 100),
                                if (!controller.signIn)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 20),
                                    child: CustomTextField(
                                      hint: 'name',
                                      controller: controller.fNameController,
                                      autofill: const [AutofillHints.email],
                                      onSubmit: (w) {
                                        controller.signingUpAuth();
                                      },
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: CustomTextField(
                                    hint: 'email',
                                    controller: controller.emailController,
                                    autofill: const [AutofillHints.email],
                                    onSubmit: (w) {
                                      if (controller.signIn) {
                                        controller.signingInAuth();
                                      } else {
                                        controller.signingUpAuth();
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: CustomTextField(
                                    hint: 'password',
                                    secure: true,
                                    controller: controller.passwordController,
                                    autofill: const [AutofillHints.password],
                                    onSubmit: (w) {
                                      if (controller.signIn) {
                                        controller.signingInAuth();
                                      } else {
                                        controller.signingUpAuth();
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomButton(
                                    loading: controller.loading,
                                    title: controller.signIn
                                        ? 'log_in'
                                        : 'sign_up',
                                    function: () async {
                                      if (controller.signIn) {
                                        controller.signingInAuth();
                                      } else {
                                        controller.signingUpAuth();
                                      }
                                    },
                                    color: appTheme.primaryColor,
                                    raduis: 10,
                                    size: 17,
                                    width: Get.width,
                                  ),
                                ),
                                if (!controller.loading && controller.signIn)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
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
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.signIn
                                          ? 'dont_have_an_account'.tr
                                          : 'already_have_an_account'.tr,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.changeMode();
                                      },
                                      child: Text(
                                        controller.signIn
                                            ? 'sign_up'.tr
                                            : 'log_in'.tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: appTheme.primaryColor),
                                      ),
                                    )
                                  ],
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
