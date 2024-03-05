import 'package:flutter/material.dart';

import '../theme/theme_helper.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final IconData prefixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.name,
      required this.prefixIcon,
      this.obscureText = false,
      this.textCapitalization = TextCapitalization.none,
      required this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.cyan400),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
          enabled: true,
          controller: controller,
          textCapitalization: textCapitalization,
          maxLength: 40,
          maxLines: 1,
          obscureText: obscureText,
          keyboardType: inputType,
          textAlign: TextAlign.start,
          style: TextStyle(color: appTheme.whiteA700, fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon, color: appTheme.tealA200),
            isDense: true,
            labelText: name,
            counterText: "",
            labelStyle: TextStyle(color: appTheme.cyan400),
            border: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
          )),
    );
  }
}
