import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/timeofday_item_widget.dart';
import 'models/timeofday_item_model.dart';
import 'models/timeofday_model.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/timeofday_provider.dart';

class TimeofdayScreen extends StatefulWidget {
  const TimeofdayScreen({Key? key}) : super(key: key);

  @override
  TimeofdayScreenState createState() => TimeofdayScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TimeofdayProvider(), child: TimeofdayScreen());
  }
}

// ignore_for_file: must_be_immutable
class TimeofdayScreenState extends State<TimeofdayScreen> {
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
                padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 29.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 59.h),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 36.adaptSize,
                                    width: 36.adaptSize,
                                    margin: EdgeInsets.only(bottom: 30.v),
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgArrowDown,
                                              height: 36.adaptSize,
                                              width: 36.adaptSize,
                                              alignment: Alignment.center),
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgArrowDown,
                                              height: 36.adaptSize,
                                              width: 36.adaptSize,
                                              alignment: Alignment.center)
                                        ])),
                                Container(
                                    height: 62.v,
                                    width: 267.h,
                                    margin:
                                        EdgeInsets.only(left: 24.h, top: 4.v),
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                  width: 267.h,
                                                  child: Text(
                                                      "msg_at_what_time_do".tr,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme.textTheme
                                                          .headlineSmall))),
                                          Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                  width: 267.h,
                                                  child: Text(
                                                      "msg_at_what_time_do".tr,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme.textTheme
                                                          .headlineSmall)))
                                        ]))
                              ])),
                      SizedBox(height: 30.v),
                      _buildTimeOfDay(context)
                    ])),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 58.h,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgMegaphone,
            margin: EdgeInsets.only(left: 30.h, top: 11.v, bottom: 13.v)),
        centerTitle: true,
        title: AppbarTitle(text: "lbl_rinvoq_15_mg".tr),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgUser,
              margin: EdgeInsets.fromLTRB(27.h, 18.v, 27.h, 13.v))
        ]);
  }

  /// Section Widget
  Widget _buildTimeOfDay(BuildContext context) {
    return Expanded(
        child: Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.h),
                child: Consumer<TimeofdayProvider>(
                    builder: (context, provider, child) {
                  return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 23.v);
                      },
                      itemCount:
                          provider.timeofdayModelObj.timeofdayItemList.length,
                      itemBuilder: (context, index) {
                        TimeofdayItemModel model =
                            provider.timeofdayModelObj.timeofdayItemList[index];
                        return TimeofdayItemWidget(model, onTapView: () {
                          onTapView(context);
                        }, onTapView1: () {
                          onTapView1(context);
                        });
                      });
                }))));
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

  /// Navigates to the iphone11ProMaxSixteenScreen when the action is triggered.
  onTapView(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxSixteenScreen,
    );
  }

  /// Navigates to the iphone11ProMaxSixteenScreen when the action is triggered.
  onTapView1(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxSixteenScreen,
    );
  }
}
