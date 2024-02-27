import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore: must_be_immutable
class TimeofdayItemWidget extends StatelessWidget {
  TimeofdayItemWidget({
    Key? key,
    this.onTapView,
    this.onTapView1,
  }) : super(
          key: key,
        );

  VoidCallback? onTapView;

  VoidCallback? onTapView1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 2.v),
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
            width: 67.h,
            margin: EdgeInsets.only(
              left: 11.h,
              top: 2.v,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Morning",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Morning",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: 130.h,
            margin: EdgeInsets.only(bottom: 2.v),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: AppDecoration.outlineCyan.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      onTapView1!.call();
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
                  width: 98.h,
                  margin: EdgeInsets.only(left: 10.h),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Before Food",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Before Food",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
