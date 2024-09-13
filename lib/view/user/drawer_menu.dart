import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              userController.changeSelectedIndex('/profile');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: appTheme.primaryColor,
                ),
              ),
            ),
          ),
          Text(
            authController.userData!.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            thickness: 1,
            height: 0,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              Get.back();
              userController.changeSelectedIndex('/mining-devices');
            },
            title: Text(
              'mining_devices'.tr,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              userController.changeSelectedIndex('/wallet');
            },
            title: Text(
              'wallet'.tr,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              userController.changeSelectedIndex('/mine');
            },
            title: Text(
              'mine'.tr,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              userController.changeSelectedIndex('/contact-us');
            },
            title: Text(
              'contact_us'.tr,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              authController.logOut();
            },
            title: Text(
              'log_out'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
