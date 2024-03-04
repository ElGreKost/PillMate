import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_radio_button.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore_for_file: must_be_immutable
class Iphone11ProMaxThirteenScreen extends StatelessWidget {
  Iphone11ProMaxThirteenScreen({Key? key}) : super(key: key);

  String radioGroup = "";

  List<String> radioList = [
    "lbl_daily",
    "lbl_once_a_week",
    "lbl_2_days_a_week",
    "lbl_3_days_a_week",
    "lbl_4_days_a_week",
    "lbl_5_days_a_week",
    "lbl_6_days_a_week",
    "lbl_once_a_month",
    "lbl_alternate_days"
  ];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 29.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildArrowDown(context),
                      SizedBox(height: 35.v),
                      _buildGroup345(context),
                      SizedBox(height: 22.v),
                      CustomElevatedButton(
                          width: 129.h,
                          text: "Next",
                          onPressed: () {
                            onTapNext(context);
                          },
                          alignment: Alignment.center),
                      SizedBox(height: 5.v)
                    ])),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 58.h,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgMegaphone,
            margin: EdgeInsets.only(left: 30.h, top: 11.v, bottom: 13.v),
            onTap: () {
              onTapMegaphone(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Rinvoq, 15 mg"),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgUser,
              margin: EdgeInsets.fromLTRB(27.h, 18.v, 27.h, 13.v))
        ]);
  }

  /// Section Widget
  Widget _buildArrowDown(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 49.h),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomImageView(
              imagePath: ImageConstant.imgArrowDown,
              height: 36.adaptSize,
              width: 36.adaptSize,
              margin: EdgeInsets.only(bottom: 26.v)),
          Expanded(
              child: Container(
                  width: 286.h,
                  margin: EdgeInsets.only(left: 15.h, top: 3.v),
                  child: Text("How often do you take this medicine?",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall)))
        ]));
  }

  /// Section Widget
  Widget _buildGroup345(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h, right: 209.h),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(right: 79.h),
              child: CustomRadioButton(
                  text: "Daily",
                  value: radioList[0],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 24.v, right: 16.h),
              child: CustomRadioButton(
                  text: "Once a week",
                  value: radioList[1],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 27.v, right: 5.h),
              child: CustomRadioButton(
                  text: "2 days a week",
                  value: radioList[2],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 25.v, right: 5.h),
              child: CustomRadioButton(
                  text: "3 days a week",
                  value: radioList[3],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 25.v),
              child: CustomRadioButton(
                  text: " 4 days a week",
                  value: radioList[4],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 26.v, right: 5.h),
              child: CustomRadioButton(
                  text: "5 days a week",
                  value: radioList[5],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 26.v, right: 5.h),
              child: CustomRadioButton(
                  text: "6 days a week",
                  value: radioList[6],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 24.v, right: 6.h),
              child: CustomRadioButton(
                  text: "Once a month",
                  value: radioList[7],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 23.v, right: 3.h),
              child: CustomRadioButton(
                  text: "Alternate days",
                  value: radioList[8],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  }))
        ]));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homescreenPage;
      case BottomBarEnum.Guide:
        return "/";
      case BottomBarEnum.Medications:
        return AppRoutes.iphone11ProMaxTwentysixPage;
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homescreenPage:
        return HomescreenPage();
      case AppRoutes.iphone11ProMaxTwentysixPage:
        return Iphone11ProMaxTwentysixPage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the settingsScreen when the action is triggered.
  onTapMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingsScreen);
  }

  /// Navigates to the choosedayScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chooseDayScreen);
  }
}
