import 'package:flutter/material.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/helper/my_app.dart';

Future<void> main() async {
  await GetInitial().initialApp();
  runApp(const MyApp());
}
