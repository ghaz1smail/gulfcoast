import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/view/widgets/icon_back.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconBack(),
        title: Text(
          'settings'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.person_remove,
              color: Colors.red,
            ),
            onTap: () {},
            title: Text('delete_account'.tr),
          )
        ],
      ),
    );
  }
}
