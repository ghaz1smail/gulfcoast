import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/admin_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/users/user_details_screen.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  late final ScrollController scrollViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    adminController.fetchUsers();
    scrollViewController.addListener(loadMoreData);
  }

  loadMoreData() {
    if (adminController.hasMoreUsers) {
      double currentPosition = scrollViewController.position.pixels;
      double maxExtent = scrollViewController.position.maxScrollExtent;
      const double threshold = 0.25;
      if (currentPosition >= maxExtent * threshold) {
        adminController.fetchMoreUsers();
      }
    }
  }

  @override
  void dispose() {
    scrollViewController.dispose();
    scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AdminController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchMoreUsers();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CupertinoSearchTextField(
                    onChanged: (value) {
                      controller.fetchSearchUsers();
                    },
                    controller: adminController.searchUserController,
                  ),
                ),
                Expanded(
                  child: (controller.searchUserController.text.isEmpty
                          ? controller.users == null
                          : controller.searchUsers == null)
                      ? const CustomLoading()
                      : (controller.searchUserController.text.isEmpty
                              ? controller.users!.isEmpty
                              : controller.searchUsers!.isEmpty)
                          ? Center(child: Text('no_data_found'.tr))
                          : ListView.builder(
                              shrinkWrap: true,
                              controller: scrollViewController,
                              itemCount:
                                  controller.searchCarController.text.isEmpty
                                      ? controller.users?.length
                                      : controller.searchUsers?.length,
                              itemBuilder: (context, index) {
                                UserModel user =
                                    controller.searchUserController.text.isEmpty
                                        ? controller.users![index]
                                        : controller.searchUsers![index];
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(() =>
                                          UserDetailsScreen(userData: user));
                                    },
                                    title: Text(user.name),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-user');
        },
        mini: true,
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
