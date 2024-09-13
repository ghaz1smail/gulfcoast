import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.function,
    required this.width,
    this.loading = false,
    this.fill = true,
    this.textColor = Colors.white,
    required this.color,
    this.size = 18.0,
    this.height = 40,
    this.raduis = 10,
    this.icon,
  });
  final String title;
  final Function function;
  final double width, size, raduis, height;
  final Color textColor, color;
  final bool loading, fill;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: MaterialButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          if (!loading) {
            function();
          }
        },
        minWidth: width,
        color: fill ? color : Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: fill ? Colors.transparent : appTheme.primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(raduis))),
        child: loading
            ? const FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : icon == null
                ? Text(
                    title.tr,
                    style: TextStyle(
                      color: textColor,
                      fontSize: size,
                    ),
                  )
                : Row(
                    children: [
                      icon!,
                      const Spacer(),
                      Text(
                        title.tr,
                        style: TextStyle(color: textColor, fontSize: size),
                      ),
                      const Spacer(),
                    ],
                  ),
      ),
    );
  }
}
