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
class Iphone11ProMaxFourteenScreen extends StatelessWidget {
  Iphone11ProMaxFourteenScreen({Key? key}) : super(key: key);

  String radioGroup = "";

  List<String> radioList = [
    "lbl_sunday",
    "lbl_monday",
    "lbl_tuesday",
    "lbl_wednesday",
    "lbl_thursday",
    "lbl_friday",
    "lbl_saturday"
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
                      _buildGroup413(context),
                      Spacer(),
                      SizedBox(height: 78.v),
                      CustomElevatedButton(
                          width: 129.h,
                          text: "Next",
                          onPressed: () {
                            onTapNext(context);
                          },
                          alignment: Alignment.center)
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
        padding: EdgeInsets.only(right: 52.h),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomImageView(
              imagePath: ImageConstant.imgArrowDown,
              height: 36.adaptSize,
              width: 36.adaptSize,
              margin: EdgeInsets.only(bottom: 26.v),
              onTap: () {
                onTapImgArrowDown(context);
              }),
          Expanded(
              child: Container(
                  width: 281.h,
                  margin: EdgeInsets.only(left: 17.h, top: 4.v),
                  child: Text("Choose the days you need to take the med",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall)))
        ]));
  }

  /// Section Widget
  Widget _buildGroup413(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h, right: 232.h),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(right: 34.h),
              child: CustomRadioButton(
                  text: "Sunday",
                  value: radioList[0],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 25.v, right: 28.h),
              child: CustomRadioButton(
                  text: "Monday",
                  value: radioList[1],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 25.v, right: 26.h),
              child: CustomRadioButton(
                  text: "Tuesday",
                  value: radioList[2],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 25.v),
              child: CustomRadioButton(
                  text: "Wednesday",
                  value: radioList[3],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 25.v, right: 18.h),
              child: CustomRadioButton(
                  text: "Thursday",
                  value: radioList[4],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 26.v, right: 44.h),
              child: CustomRadioButton(
                  text: "Friday",
                  value: radioList[5],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  })),
          Padding(
              padding: EdgeInsets.only(top: 26.v, right: 22.h),
              child: CustomRadioButton(
                  text: "Saturday",
                  value: radioList[6],
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

  /// Navigates to the iphone11ProMaxThirteenScreen when the action is triggered.
  onTapImgArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.iphone11ProMaxThirteenScreen);
  }

  /// Navigates to the timeofdayScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.timeofdayScreen);
  }
}
