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
class Iphone11ProMaxSixteenScreen extends StatelessWidget {
  Iphone11ProMaxSixteenScreen({Key? key}) : super(key: key);

  String radioGroup = "";

  List<String> radioList = ["lbl_morning", "lbl_before_food"];

  String radioGroup1 = "";

  List<String> radioList1 = ["lbl_afternoon", "lbl_after_food"];

  String radioGroup2 = "";

  List<String> radioList2 = ["lbl_evening", "lbl_anytime"];

  String radioGroup3 = "";

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
                      Padding(
                          padding: EdgeInsets.only(right: 59.h),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgArrowDown,
                                    height: 36.adaptSize,
                                    width: 36.adaptSize,
                                    margin: EdgeInsets.only(bottom: 30.v),
                                    onTap: () {
                                      onTapImgArrowDown(context);
                                    }),
                                Expanded(
                                    child: Container(
                                        width: 267.h,
                                        margin: EdgeInsets.only(
                                            left: 24.h, top: 4.v),
                                        child: Text(
                                            "At what time do you take your first dose?",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style:
                                                theme.textTheme.headlineSmall)))
                              ])),
                      SizedBox(height: 30.v),
                      _buildGroup246(context),
                      SizedBox(height: 23.v),
                      _buildGroup245(context),
                      SizedBox(height: 26.v),
                      _buildGroup427(context),
                      SizedBox(height: 25.v),
                      _buildNight(context),
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
  Widget _buildGroup246(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.h),
            child: Row(children: [
              CustomRadioButton(
                  text: "Morning",
                  value: radioList[0],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  }),
              Padding(
                  padding: EdgeInsets.only(left: 106.h, bottom: 2.v),
                  child: CustomRadioButton(
                      text: "Before Food",
                      value: radioList[1],
                      groupValue: radioGroup,
                      onChange: (value) {
                        radioGroup = value;
                      }))
            ])));
  }

  /// Section Widget
  Widget _buildGroup245(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h, right: 39.h),
        child: Row(children: [
          CustomRadioButton(
              text: "Afternoon",
              value: radioList1[0],
              groupValue: radioGroup1,
              onChange: (value) {
                radioGroup1 = value;
              }),
          Padding(
              padding: EdgeInsets.only(left: 93.h),
              child: CustomRadioButton(
                  text: "After Food",
                  value: radioList1[1],
                  groupValue: radioGroup1,
                  onChange: (value) {
                    radioGroup1 = value;
                  }))
        ]));
  }

  /// Section Widget
  Widget _buildGroup427(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h, right: 58.h),
        child: Row(children: [
          CustomRadioButton(
              text: "Evening",
              value: radioList2[0],
              groupValue: radioGroup2,
              onChange: (value) {
                radioGroup2 = value;
              }),
          Padding(
              padding: EdgeInsets.only(left: 110.h),
              child: CustomRadioButton(
                  text: "Anytime",
                  value: radioList2[1],
                  groupValue: radioGroup2,
                  onChange: (value) {
                    radioGroup2 = value;
                  }))
        ]));
  }

  /// Section Widget
  Widget _buildNight(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h),
        child: CustomRadioButton(
            text: "Night",
            value: "Night",
            groupValue: radioGroup3,
            onChange: (value) {
              radioGroup3 = value;
            }));
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

  /// Navigates to the iphone11ProMaxFourteenScreen when the action is triggered.
  onTapImgArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.selectDayScreen);
  }

  /// Navigates to the settimeScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settimeScreen);
  }
}
