import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_radio_button.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'models/iphone_11_pro_max_thirteen_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/iphone_11_pro_max_thirteen_provider.dart';

class Iphone11ProMaxThirteenScreen extends StatefulWidget {
  const Iphone11ProMaxThirteenScreen({Key? key}) : super(key: key);

  @override
  Iphone11ProMaxThirteenScreenState createState() =>
      Iphone11ProMaxThirteenScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Iphone11ProMaxThirteenProvider(),
        child: Iphone11ProMaxThirteenScreen());
  }
}

// ignore_for_file: must_be_immutable
class Iphone11ProMaxThirteenScreenState
    extends State<Iphone11ProMaxThirteenScreen> {
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
                      _buildArrowDown(context),
                      SizedBox(height: 35.v),
                      _buildGroup345(context),
                      SizedBox(height: 22.v),
                      CustomElevatedButton(
                          width: 129.h,
                          text: "lbl_next".tr,
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
        title: AppbarTitle(text: "lbl_rinvoq_15_mg".tr),
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
                  child: Text("msg_how_often_do_you".tr,
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
        child: Consumer<Iphone11ProMaxThirteenProvider>(
            builder: (context, provider, child) {
          return provider.iphone11ProMaxThirteenModelObj!.radioList.isNotEmpty
              ? Column(children: [
                  Padding(
                      padding: EdgeInsets.only(right: 79.h),
                      child: CustomRadioButton(
                          text: "lbl_daily".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[0] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 24.v, right: 16.h),
                      child: CustomRadioButton(
                          text: "lbl_once_a_week".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[1] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 27.v, right: 5.h),
                      child: CustomRadioButton(
                          text: "lbl_2_days_a_week".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[2] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 25.v, right: 5.h),
                      child: CustomRadioButton(
                          text: "lbl_3_days_a_week".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[3] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 25.v),
                      child: CustomRadioButton(
                          text: "lbl_4_days_a_week".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[4] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 26.v, right: 5.h),
                      child: CustomRadioButton(
                          text: "lbl_5_days_a_week".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[5] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 26.v, right: 5.h),
                      child: CustomRadioButton(
                          text: "lbl_6_days_a_week".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[6] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 24.v, right: 6.h),
                      child: CustomRadioButton(
                          text: "lbl_once_a_month".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[7] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 23.v, right: 3.h),
                      child: CustomRadioButton(
                          text: "lbl_alternate_days".tr,
                          value: provider.iphone11ProMaxThirteenModelObj
                                  ?.radioList[8] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          }))
                ])
              : Container();
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

  /// Navigates to the choosedayScreen when the action is triggered.
  onTapNext(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.choosedayScreen,
    );
  }
}
