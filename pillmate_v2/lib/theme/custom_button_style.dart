import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillCyan => ElevatedButton.styleFrom(
        backgroundColor: appTheme.cyan500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.h),
        ),
      );
}
