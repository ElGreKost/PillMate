import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_text_form_field.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AddmedicationScreen extends StatelessWidget {
  AddmedicationScreen({Key? key}) : super(key: key);

  TextEditingController editTextController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 30.v),
                child: Column(children: [
                  _buildArrowDown(context),
                  SizedBox(height: 48.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.h),
                      child: CustomTextFormField(
                          controller: editTextController,
                          textInputAction: TextInputAction.done)),
                  SizedBox(height: 8.v),
                  SizedBox(
                      height: 17.v,
                      width: 246.h,
                      child: Stack(alignment: Alignment.center, children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Type and choose your med from the list",
                                style: theme.textTheme.bodyMedium)),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Type and choose your med from the list",
                                style: theme.textTheme.bodyMedium))
                      ])),
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
                        alignment: Alignment.center),
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
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the settingsScreen when the action is triggered.
  onTapMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingsScreen);
  }
}
