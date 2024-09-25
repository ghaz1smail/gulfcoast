import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: CircleAvatar(
            backgroundColor: appTheme.primaryColor,
            radius: 40,
            child: const Icon(
              Icons.person,
              size: 30,
            ),
          ),
        ),
        Text(
          authController.userData!.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          authController.userData!.company,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.settings,
          ),
          onTap: () {
            Get.toNamed('/settings');
          },
          title: Text('settings'.tr),
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          onTap: () {
            authController.logOut();
          },
          title: Text('logout'.tr),
        )
      ],
    );
  }
}
