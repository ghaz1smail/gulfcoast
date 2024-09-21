import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
