import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore: must_be_immutable
class View1ItemWidget extends StatelessWidget {
  const View1ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: AppDecoration.outlineCyan400.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Container(
            height: 21.adaptSize,
            width: 21.adaptSize,
            decoration: BoxDecoration(
              color: appTheme.cyan500,
              borderRadius: BorderRadius.circular(
                10.h,
              ),
              border: Border.all(
                color: appTheme.cyan500,
                width: 2.h,
              ),
            ),
          ),
        ),
        Container(
          height: 22.v,
          width: 25.h,
          margin: EdgeInsets.only(left: 20.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Pill",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Pill",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
