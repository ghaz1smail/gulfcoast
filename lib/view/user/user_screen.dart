import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/user/cars/auction_cars.dart';
import 'package:gulfcoast/view/user/cars/user_cars.dart';
import 'package:gulfcoast/view/user/profile/profile_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'app_name'.tr,
                style: const TextStyle(color: Colors.black),
              ),
              bottom: TabBar(
                  labelStyle: TextStyle(color: appTheme.primaryColor),
                  indicatorColor: appTheme.primaryColor,
                  tabs: [
                    Tab(text: 'vehicles'.tr),
                    Tab(text: 'auction'.tr),
                    Tab(text: 'profile'.tr),
                  ]),
            ),
            body: const TabBarView(children: [
              UserCars(),
              AuctionCars(
                guest: false,
              ),
              UserProfile()
            ])));
  }
}
