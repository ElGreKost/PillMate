import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_radio_button.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'models/iphone_11_pro_max_sixteen_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/iphone_11_pro_max_sixteen_provider.dart';

class Iphone11ProMaxSixteenScreen extends StatefulWidget {
  const Iphone11ProMaxSixteenScreen({Key? key}) : super(key: key);

  @override
  Iphone11ProMaxSixteenScreenState createState() =>
      Iphone11ProMaxSixteenScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Iphone11ProMaxSixteenProvider(),
        child: Iphone11ProMaxSixteenScreen());
  }
}

// ignore_for_file: must_be_immutable
class Iphone11ProMaxSixteenScreenState
    extends State<Iphone11ProMaxSixteenScreen> {
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
                                        child: Text("msg_at_what_time_do".tr,
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
                          text: "lbl_next".tr,
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
        title: AppbarTitle(text: "lbl_rinvoq_15_mg".tr),
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
            child: Consumer<Iphone11ProMaxSixteenProvider>(
                builder: (context, provider, child) {
              return provider
                      .iphone11ProMaxSixteenModelObj!.radioList.isNotEmpty
                  ? Row(children: [
                      CustomRadioButton(
                          text: "lbl_morning".tr,
                          value: provider.iphone11ProMaxSixteenModelObj
                                  ?.radioList[0] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          }),
                      Padding(
                          padding: EdgeInsets.only(left: 106.h, bottom: 2.v),
                          child: CustomRadioButton(
                              text: "lbl_before_food".tr,
                              value: provider.iphone11ProMaxSixteenModelObj
                                      ?.radioList[1] ??
                                  "",
                              groupValue: provider.radioGroup,
                              onChange: (value) {
                                provider.changeRadioButton1(value);
                              }))
                    ])
                  : Container();
            })));
  }

  /// Section Widget
  Widget _buildGroup245(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h, right: 39.h),
        child: Consumer<Iphone11ProMaxSixteenProvider>(
            builder: (context, provider, child) {
          return provider.iphone11ProMaxSixteenModelObj!.radioList1.isNotEmpty
              ? Row(children: [
                  CustomRadioButton(
                      text: "lbl_afternoon".tr,
                      value: provider
                              .iphone11ProMaxSixteenModelObj?.radioList1[0] ??
                          "",
                      groupValue: provider.radioGroup1,
                      onChange: (value) {
                        provider.changeRadioButton2(value);
                      }),
                  Padding(
                      padding: EdgeInsets.only(left: 93.h),
                      child: CustomRadioButton(
                          text: "lbl_after_food".tr,
                          value: provider.iphone11ProMaxSixteenModelObj
                                  ?.radioList1[1] ??
                              "",
                          groupValue: provider.radioGroup1,
                          onChange: (value) {
                            provider.changeRadioButton2(value);
                          }))
                ])
              : Container();
        }));
  }

  /// Section Widget
  Widget _buildGroup427(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h, right: 58.h),
        child: Consumer<Iphone11ProMaxSixteenProvider>(
            builder: (context, provider, child) {
          return provider.iphone11ProMaxSixteenModelObj!.radioList2.isNotEmpty
              ? Row(children: [
                  CustomRadioButton(
                      text: "lbl_evening".tr,
                      value: provider
                              .iphone11ProMaxSixteenModelObj?.radioList2[0] ??
                          "",
                      groupValue: provider.radioGroup2,
                      onChange: (value) {
                        provider.changeRadioButton3(value);
                      }),
                  Padding(
                      padding: EdgeInsets.only(left: 110.h),
                      child: CustomRadioButton(
                          text: "lbl_anytime".tr,
                          value: provider.iphone11ProMaxSixteenModelObj
                                  ?.radioList2[1] ??
                              "",
                          groupValue: provider.radioGroup2,
                          onChange: (value) {
                            provider.changeRadioButton3(value);
                          }))
                ])
              : Container();
        }));
  }

  /// Section Widget
  Widget _buildNight(BuildContext context) {
    return Consumer<Iphone11ProMaxSixteenProvider>(
        builder: (context, provider, child) {
      return Padding(
          padding: EdgeInsets.only(left: 26.h),
          child: CustomRadioButton(
              text: "lbl_night".tr,
              value: "lbl_night".tr,
              groupValue: provider.radioGroup3,
              onChange: (value) {
                provider.changeRadioButton4(value);
              }));
    });
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

  /// Navigates to the iphone11ProMaxFourteenScreen when the action is triggered.
  onTapImgArrowDown(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxFourteenScreen,
    );
  }

  /// Navigates to the settimeScreen when the action is triggered.
  onTapNext(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.settimeScreen,
    );
  }
}
