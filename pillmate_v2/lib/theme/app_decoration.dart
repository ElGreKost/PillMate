import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

class AppDecoration {
  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(color: appTheme.cyan500, boxShadow: [
        BoxShadow(color: appTheme.black900.withOpacity(0.27), spreadRadius: 2.h, blurRadius: 2.h, offset: Offset(5, 4))
      ]);

  // White decorations
  static BoxDecoration get white => BoxDecoration(
      color: appTheme.grey900,
      border: Border(
          top: BorderSide(color: appTheme.whiteA700, width: 2.h),
          left: BorderSide(color: appTheme.whiteA700, width: 2.h)),
      boxShadow: [
        BoxShadow(color: appTheme.black900.withOpacity(0.25), spreadRadius: 2.h, blurRadius: 2.h, offset: Offset(0, 4))
      ],
      borderRadius: BorderRadius.circular(30.h));
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder29 => BorderRadius.circular(30.h);

  // Rounded borders
  static BorderRadius get roundedBorder25 => BorderRadius.circular(25.h);
}
