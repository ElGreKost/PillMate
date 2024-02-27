import '../models/view1_item_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore: must_be_immutable
class View1ItemWidget extends StatelessWidget {
  View1ItemWidget(
    this.view1ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  View1ItemModel view1ItemModelObj;

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
              color: appTheme.cyan400,
              borderRadius: BorderRadius.circular(
                10.h,
              ),
              border: Border.all(
                color: appTheme.cyan400,
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
                  view1ItemModelObj.pill!,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  view1ItemModelObj.pill1!,
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
