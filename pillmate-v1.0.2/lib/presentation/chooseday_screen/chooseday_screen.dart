import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/chooseday_item_widget.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
// todo this is not the choose day screen xD
// ignore_for_file: must_be_immutable
class ChoosedayScreen extends StatelessWidget {
  ChoosedayScreen({Key? key}) : super(key: key);

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
                      _buildChooseDay(context),
                      Spacer(),
                      SizedBox(height: 86.v),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 30.v,
                              width: 54.h,
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Text("Next",
                                        style: CustomTextStyles
                                            .headlineSmallGray900Bold)),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text("Next",
                                        style: CustomTextStyles
                                            .headlineSmallGray900Bold))
                              ])))
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
          Container(
              height: 36.adaptSize,
              width: 36.adaptSize,
              margin: EdgeInsets.only(bottom: 26.v),
              child: Stack(alignment: Alignment.center, children: [
                CustomImageView(
                    imagePath: ImageConstant.imgArrowDown,
                    height: 36.adaptSize,
                    width: 36.adaptSize,
                    alignment: Alignment.center),
                CustomImageView(
                    imagePath: ImageConstant.imgArrowDown,
                    height: 36.adaptSize,
                    width: 36.adaptSize,
                    alignment: Alignment.center)
              ])),
          Container(
              height: 57.v,
              width: 281.h,
              margin: EdgeInsets.only(left: 17.h, top: 4.v),
              child: Stack(alignment: Alignment.center, children: [
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 281.h,
                        child: Text("Choose the days you need to take the med",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall))),
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 281.h,
                        child: Text("Choose the days you need to take the med",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall)))
              ]))
        ]));
  }

  /// Section Widget
  Widget _buildChooseDay(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h, right: 232.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 25.v);
            },
            itemCount: 7,
            itemBuilder: (context, index) {
              return ChoosedayItemWidget(onTapView: () {
                onTapView(context);
              });
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
  onTapView(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.selectDayScreen);
  }
}
