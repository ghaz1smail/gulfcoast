import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomChip extends StatelessWidget {
  final String title;
  final String textToCopy;
  const CustomChip({super.key, required this.title, this.textToCopy = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (textToCopy.isNotEmpty) {
          Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          title,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
