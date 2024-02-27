import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'models/iphone_11_pro_max_three_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/iphone_11_pro_max_three_provider.dart';

class Iphone11ProMaxThreeScreen extends StatefulWidget {
  const Iphone11ProMaxThreeScreen({Key? key}) : super(key: key);

  @override
  Iphone11ProMaxThreeScreenState createState() =>
      Iphone11ProMaxThreeScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Iphone11ProMaxThreeProvider(),
        child: Iphone11ProMaxThreeScreen());
  }
}

// ignore_for_file: must_be_immutable
class Iphone11ProMaxThreeScreenState extends State<Iphone11ProMaxThreeScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

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
                      text: "lbl_next".tr,
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
        title: AppbarTitle(text: "lbl_add_medication".tr),
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
                            child: Text("msg_what_medicine_do".tr,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineSmall))),
                    Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 299.h,
                            child: Text("msg_what_medicine_do".tr,
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
                  child: Text("lbl_rinvoq".tr,
                      style: CustomTextStyles.titleLarge20)),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("lbl_rinvoq".tr,
                      style: CustomTextStyles.titleLarge20))
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
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.homescreenPage:
        return HomescreenPage.builder(context);
      case AppRoutes.iphone11ProMaxTwentysixPage:
        return Iphone11ProMaxTwentysixPage.builder(context);
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the settingsScreen when the action is triggered.
  onTapMegaphone(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.settingsScreen,
    );
  }

  /// Navigates to the homescreenContainerScreen when the action is triggered.
  onTapImgArrowDown(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.homescreenContainerScreen,
    );
  }

  /// Navigates to the iphone11ProMaxFiveScreen when the action is triggered.
  onTapNext(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxFiveScreen,
    );
  }
}
