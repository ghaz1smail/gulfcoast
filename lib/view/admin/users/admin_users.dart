import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/controllers/admin_controller.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/user_model.dart';
import 'package:gulfcoast/view/admin/users/user_details_screen.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class AdminUsers extends StatelessWidget {
  const AdminUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AdminController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.updateUI();
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
                    child: adminController.searchUserController.text.isNotEmpty
                        ? FutureBuilder(
                            future: firestore
                                .collection('users')
                                .where('tags', arrayContainsAny: [
                              adminController
                                  .searchUserController.text.removeAllWhitespace
                                  .toUpperCase(),
                            ]).get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<UserModel> users = snapshot.data!.docs
                                    .map((m) => UserModel.fromJson(m.data()))
                                    .toList();

                                if (users.isEmpty) {
                                  return Center(
                                      child: Text(
                                    'no_data_found'.tr,
                                  ));
                                }
                                return ListView.builder(
                                  itemCount: users.length,
                                  itemBuilder: (context, index) {
                                    UserModel user = users[index];
                                    return Card(
                                      child: ListTile(
                                        onTap: () async {
                                          await Get.to(() => UserDetailsScreen(
                                              userData: user));
                                          controller.updateUI();
                                        },
                                        title: Text(user.name),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const CustomLoading();
                            },
                          )
                        : PaginateFirestore(
                            onEmpty: SizedBox(
                              height: Get.height * 0.75,
                              child: Center(
                                  child: Text(
                                'no_data_found'.tr,
                              )),
                            ),
                            initialLoader: SizedBox(
                                height: Get.height * 0.75,
                                child: const CustomLoading()),
                            itemBuilder: (context, documentSnapshots, index) {
                              UserModel user = UserModel.fromJson(
                                  documentSnapshots[index].data() as Map);
                              return Card(
                                child: ListTile(
                                  onTap: () async {
                                    await Get.to(() =>
                                        UserDetailsScreen(userData: user));
                                    controller.updateUI();
                                  },
                                  title: Text(user.name),
                                ),
                              );
                            },
                            query: firestore
                                .collection('users')
                                .where('type', isEqualTo: 'user'),
                            itemBuilderType: PaginateBuilderType.listView,
                            isLive: true,
                          ))
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
