import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 500;
    return AppBar(
      title: TextButton(
        onPressed: () {},
        child: Text(
          'app_name'.tr,
          style: TextStyle(
              color: appTheme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
      actions: isMobile
          ? [
              Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    )),
              )
            ]
          : [
              TextButton(
                onPressed: () {},
                child: Text(
                  'mining_devices'.tr,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'wallet'.tr,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'mine'.tr,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'contact_us'.tr,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: appTheme.primaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
    );
  }
}
