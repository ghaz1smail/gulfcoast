import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/user_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/user/contact_us/contact_us_screen.dart';
import 'package:gulfcoast/view/user/custom_app_bar.dart';
import 'package:gulfcoast/view/user/devices/mining_devices_screen.dart';
import 'package:gulfcoast/view/user/drawer_menu.dart';
import 'package:gulfcoast/view/user/home/home_screen.dart';
import 'package:gulfcoast/view/user/mine/mine_screen.dart';
import 'package:gulfcoast/view/user/profile/profile_screen.dart';
import 'package:gulfcoast/view/user/wallet/wallet_screen.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 500;
    return Scaffold(
        appBar: const CustomAppBar(),
        endDrawer: isMobile ? const DrawerMenu() : null,
        body: GetBuilder(
          initState: (state) {
            userController.checkUserRoute(updateData: false);
          },
          init: UserController(),
          builder: (controller) {
            return controller.checking
                ? const CustomLoading()
                : IndexedStack(
                    index: controller.selectedIndex.value,
                    children: const [
                      HomeScreen(),
                      MiningDevicesScreen(),
                      WalletScreen(),
                      MineScreen(),
                      ContactUsScreen(),
                      ProfileScreen()
                    ],
                  );
          },
        ));
  }
}
