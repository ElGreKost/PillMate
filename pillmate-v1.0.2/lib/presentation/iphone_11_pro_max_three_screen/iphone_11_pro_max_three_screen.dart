import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore_for_file: must_be_immutable
class Iphone11ProMaxThreeScreen extends StatelessWidget {
  Iphone11ProMaxThreeScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 30.v),
                child: Column(children: [
                  _buildArrowDown(context),
                  SizedBox(height: 47.v),
                  _buildSeven(context),
                  Spacer(),
                  SizedBox(height: 77.v),
                  CustomElevatedButton(
                      width: 129.h,
                      text: "Next",
                      onPressed: () {
                        onTapNext(context);
                      })
                ])),
            bottomNavigationBar: _buildBottomBar(context)));
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
        centerTitle: true,
        title: AppbarTitle(text: "Add medication"),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgUser,
              margin: EdgeInsets.fromLTRB(27.h, 19.v, 27.h, 12.v))
        ]);
  }

  /// Section Widget
  Widget _buildArrowDown(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(right: 44.h),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: 36.adaptSize,
                  width: 36.adaptSize,
                  margin: EdgeInsets.only(bottom: 26.v),
                  child: Stack(alignment: Alignment.center, children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgArrowDown,
                        height: 36.adaptSize,
                        width: 36.adaptSize,
                        alignment: Alignment.center,
                        onTap: () {
                          onTapImgArrowDown(context);
                        }),
                    CustomImageView(
                        imagePath: ImageConstant.imgArrowDown,
                        height: 36.adaptSize,
                        width: 36.adaptSize,
                        alignment: Alignment.center)
                  ])),
              Container(
                  height: 57.v,
                  width: 299.h,
                  margin: EdgeInsets.only(left: 9.h, top: 4.v),
                  child: Stack(alignment: Alignment.center, children: [
                    Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 299.h,
                            child: Text("What medicine do you want\nto add?",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineSmall))),
                    Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 299.h,
                            child: Text("What medicine do you want\nto add?",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineSmall)))
                  ]))
            ])));
  }

  /// Section Widget
  Widget _buildSeven(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: appTheme.tealA200, width: 1.h),
            borderRadius: BorderRadiusStyle.roundedBorder25),
        child: Container(
            height: 61.v,
            width: 376.h,
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 17.v),
            decoration: AppDecoration.outlineTealA
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder25),
            child: Stack(alignment: Alignment.bottomLeft, children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Rinvoq", style: CustomTextStyles.titleLarge20)),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Rinvoq", style: CustomTextStyles.titleLarge20))
            ])));
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

  /// Navigates to the homescreenContainerScreen when the action is triggered.
  onTapImgArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homescreenPage);
  }

  /// Navigates to the iphone11ProMaxFiveScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.iphone11ProMaxFiveScreen);
  }
}
