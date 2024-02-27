import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray900,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.cyan400,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.27),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              5,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: appTheme.gray900,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              3,
              3,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        color: appTheme.gray900,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              -4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack9002 => BoxDecoration(
        color: appTheme.gray900,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.27),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              5,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineCyan => BoxDecoration(
        border: Border.all(
          color: appTheme.cyan400,
          width: 2.h,
        ),
      );
  static BoxDecoration get outlineCyan400 => BoxDecoration(
        color: appTheme.cyan400,
        border: Border.all(
          color: appTheme.cyan400,
          width: 2.h,
        ),
      );
  static BoxDecoration get outlineTealA => BoxDecoration(
        border: Border.all(
          color: appTheme.tealA200,
          width: 1.h,
          strokeAlign: strokeAlignOutside,
        ),
      );

  // White decorations
  static BoxDecoration get white => BoxDecoration(
        color: appTheme.gray900,
        border: Border(
          top: BorderSide(
            color: appTheme.whiteA700,
            width: 2.h,
          ),
          left: BorderSide(
            color: appTheme.whiteA700,
            width: 2.h,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder1 => BorderRadius.circular(
        1.h,
      );
  static BorderRadius get circleBorder29 => BorderRadius.circular(
        29.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder17 => BorderRadius.circular(
        17.h,
      );
  static BorderRadius get roundedBorder22 => BorderRadius.circular(
        22.h,
      );
  static BorderRadius get roundedBorder25 => BorderRadius.circular(
        25.h,
      );
  static BorderRadius get roundedBorder33 => BorderRadius.circular(
        33.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
