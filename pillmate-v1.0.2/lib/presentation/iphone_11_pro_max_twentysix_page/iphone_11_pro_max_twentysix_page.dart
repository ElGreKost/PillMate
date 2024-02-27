import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_button.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/time_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

class Iphone11ProMaxTwentysixPage extends StatelessWidget {
  const Iphone11ProMaxTwentysixPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 19.h, vertical: 16.v),
                child: Column(children: [
                  SizedBox(height: 36.v),
                  _buildTime(context),
                  Spacer(),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 37.h),
                          child: Text("Add notes",
                              style: CustomTextStyles.bodyMediumGray900))),
                  SizedBox(height: 21.v),
                  _buildCalendar(context)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 58.h,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgMegaphone,
            margin: EdgeInsets.only(left: 30.h, top: 12.v, bottom: 12.v),
            onTap: () {
              onTapMegaphone(context);
            }),
        actions: [
          AppbarTrailingButton(
              margin: EdgeInsets.fromLTRB(27.h, 16.v, 12.h, 3.v)),
          AppbarTrailingImage(
              imagePath: ImageConstant.imgUser,
              margin: EdgeInsets.only(left: 18.h, top: 19.v, right: 39.h))
        ]);
  }

  /// Section Widget
  Widget _buildTime(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 35.v);
        },
        itemCount: 2,
        itemBuilder: (context, index) {
          return TimeItemWidget();
        });
  }

  /// Section Widget
  Widget _buildCalendar(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomImageView(
              imagePath: ImageConstant.imgCalendar, height: 38.v, width: 34.h),
          CustomImageView(
              imagePath: ImageConstant.imgClose,
              height: 38.adaptSize,
              width: 38.adaptSize)
        ]));
  }

  /// Navigates to the settingsScreen when the action is triggered.
  onTapMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingsScreen);
  }
}
