import 'package:flutter/material.dart';
import '../theme/theme_helper.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final IconData prefixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final FocusNode? focusNode; // Existing focusNode parameter
  final Function(String)? onChanged; // New onChanged callback parameter
  final bool autofocus;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.name,
    required this.prefixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    required this.inputType,
    this.focusNode, // Existing focusNode initialization
    this.onChanged,
    this.autofocus = false, // Initialize onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.cyan500),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        autofocus: autofocus,
        enabled: true,
        controller: controller,
        focusNode: focusNode,
        // Use the focusNode here
        textCapitalization: textCapitalization,
        maxLength: 40,
        maxLines: 1,
        obscureText: obscureText,
        keyboardType: inputType,
        textAlign: TextAlign.start,
        style: TextStyle(color: appTheme.whiteA700, fontSize: 16),
        onChanged: onChanged,
        // Use the onChanged callback here
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: appTheme.teal500),
          isDense: true,
          labelText: name,
          counterText: "",
          labelStyle: TextStyle(color: appTheme.cyan500),
          border: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
        ),
      ),
    );
  }
}
