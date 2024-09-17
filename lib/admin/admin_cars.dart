import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/add_car_dialog.dart';

class AdminCars extends StatelessWidget {
  const AdminCars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [CupertinoSearchTextField()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customUi.customDialog(const AddCarDialog());
        },
        mini: true,
        child: const Icon(Icons.drive_eta),
      ),
    );
  }
}
