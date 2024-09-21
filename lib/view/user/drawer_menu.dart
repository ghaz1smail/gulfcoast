import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
              ),
            ),
            Text(
              authController.userData!.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
              height: 0,
            ),
            ListTile(
              onTap: () {
                Get.back();
              },
              title: Text(
                'contact_us'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
