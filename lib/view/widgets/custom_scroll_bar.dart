import 'package:flutter/material.dart';

class CustomScrollBar extends StatelessWidget {
  final Widget child;
  const CustomScrollBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
      ),
      child: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: child,
          )),
    );
  }
}
