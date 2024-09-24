import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/models/filter_model.dart';
import 'package:gulfcoast/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class FilterBottomSheet extends StatelessWidget {
  final ScrollController customScrollController;
  final String maker;
  final Function onTap;

  const FilterBottomSheet(
      {super.key,
      required this.customScrollController,
      required this.onTap,
      this.maker = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(10),
        //   child: CupertinoSearchTextField(
        //     onChanged: (value) {},
        //     controller: adminController.searchCarController,
        //   ),
        // ),

        Expanded(
            child: PaginateFirestore(
          scrollController: customScrollController,
          onEmpty: SizedBox(
            height: Get.height * 0.9,
            child: Center(
                child: Text(
              'no_data_found'.tr,
            )),
          ),
          initialLoader:
              SizedBox(height: Get.height * 0.9, child: const CustomLoading()),
          itemBuilder: (context, documentSnapshots, index) {
            FilterModel filter =
                FilterModel.fromJson(documentSnapshots[index].data() as Map);
            return Card(
              child: ListTile(
                onTap: () {
                  onTap(filter.title);
                },
                title: Text(filter.title),
                trailing: Text('(${filter.cars!.length})'),
              ),
            );
          },
          query: maker.isEmpty
              ? firestore.collection('makers')
              : firestore.collection('models').where('maker', isEqualTo: maker),
          itemBuilderType: PaginateBuilderType.listView,
        ))
      ],
    );
  }
}
