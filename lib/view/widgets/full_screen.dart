import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/view/widgets/cached_network_image.dart';

class FullScreen extends StatelessWidget {
  final List<String> urls;
  const FullScreen({super.key, required this.urls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: PageView(
        children: urls
            .map((m) => CustomImageNetwork(
                url: m,
                width: Get.width,
                height: Get.height,
                boxFit: BoxFit.contain))
            .toList(),
      ),
    );
  }
}
