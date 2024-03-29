import 'package:pillmate/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitleButton extends StatelessWidget {
  AppbarTitleButton({
    Key? key,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomElevatedButton(
          height: 24.v,
          width: 108.h,
          text: "msg_book_appointment".tr,
          buttonStyle: CustomButtonStyles.fillCyan,
          buttonTextStyle: theme.textTheme.labelSmall!,
        ),
      ),
    );
  }
}
