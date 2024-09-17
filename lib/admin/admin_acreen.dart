import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/admin/admin_cars.dart';
import 'package:gulfcoast/admin/admin_dashboard.dart';
import 'package:gulfcoast/admin/admin_profile.dart';
import 'package:gulfcoast/admin/admin_users.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'admin'.tr,
                style: const TextStyle(color: Colors.black),
              ),
              bottom: TabBar(
                  labelStyle: TextStyle(color: appTheme.primaryColor),
                  indicatorColor: appTheme.primaryColor,
                  tabs: [
                    Tab(text: 'dashboard'.tr),
                    Tab(text: 'cars'.tr),
                    Tab(text: 'users'.tr),
                    Tab(text: 'profile'.tr),
                  ]),
            ),
            body: const TabBarView(children: [
              AdminDashboard(),
              AdminCars(),
              AdminUsers(),
              AdminProfile()
            ])));
  }
}
