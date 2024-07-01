import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  static get headlineSmallBold => theme.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallGray900Bold =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.grey500,
        fontSize: 25.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeffffffff => theme.textTheme.titleLarge!.copyWith(
        color: Color(0XFFFFFFFF),
        fontSize: 20.fSize,
      );
}

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }
}
