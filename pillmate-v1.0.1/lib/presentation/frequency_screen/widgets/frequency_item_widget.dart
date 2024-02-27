import '../models/frequency_item_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore: must_be_immutable
class FrequencyItemWidget extends StatelessWidget {
  FrequencyItemWidget(
    this.frequencyItemModelObj, {
    Key? key,
    this.onTapView,
  }) : super(
          key: key,
        );

  FrequencyItemModel frequencyItemModelObj;

  VoidCallback? onTapView;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 1.v),
          decoration: AppDecoration.outlineCyan.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: GestureDetector(
            onTap: () {
              onTapView!.call();
            },
            child: Container(
              height: 21.adaptSize,
              width: 21.adaptSize,
              decoration: BoxDecoration(
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
        ),
        Container(
          height: 22.v,
          width: 39.h,
          margin: EdgeInsets.only(left: 13.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  frequencyItemModelObj.daily!,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  frequencyItemModelObj.daily1!,
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
