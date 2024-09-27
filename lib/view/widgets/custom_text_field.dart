import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.secure = false,
      this.controller,
      this.autofill,
      required this.hint,
      this.length = 0,
      this.onChange,
      this.onSubmit,
      this.type = TextInputType.emailAddress});

  final TextEditingController? controller;
  final String hint;
  final bool secure;
  final TextInputType type;
  final int length;
  final Function? onChange, onSubmit;
  final Iterable<String>? autofill;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      maxLength: widget.length == 0 ? null : widget.length,
      minLines: widget.type == TextInputType.multiline ? null : 1,
      maxLines: widget.type == TextInputType.multiline ? 3 : 1,
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      onFieldSubmitted: (w) {
        if (widget.onSubmit != null) {
          widget.onSubmit!(w);
        }
      },
      cursorColor: appTheme.primaryColor,
      autofillHints: widget.autofill,
      controller: widget.controller,
      keyboardType: widget.type,
      inputFormatters: widget.type == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      obscureText: widget.secure ? showPass : false,
      decoration: InputDecoration(
        labelText: widget.hint.tr,
        labelStyle: TextStyle(
          fontSize: 16,
          color: appTheme.primaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        suffixIcon: widget.secure && widget.controller!.text.isNotEmpty
            ? TextButton(
                onPressed: (() {
                  setState(() {
                    showPass = !showPass;
                  });
                }),
                child: Text(showPass ? 'show'.tr : 'hide'.tr,
                    style: TextStyle(
                        color: appTheme.primaryColor,
                        fontWeight: FontWeight.bold)))
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            7.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              7.5,
            ),
            borderSide: BorderSide(color: appTheme.primaryColor, width: 2)),
      ),
    );
  }
}
