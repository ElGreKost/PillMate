import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_radio_button.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'models/iphone_11_pro_max_fourteen_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/iphone_11_pro_max_fourteen_provider.dart';

class Iphone11ProMaxFourteenScreen extends StatefulWidget {
  const Iphone11ProMaxFourteenScreen({Key? key}) : super(key: key);

  @override
  Iphone11ProMaxFourteenScreenState createState() =>
      Iphone11ProMaxFourteenScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Iphone11ProMaxFourteenProvider(),
        child: Iphone11ProMaxFourteenScreen());
  }
}

// ignore_for_file: must_be_immutable
class Iphone11ProMaxFourteenScreenState
    extends State<Iphone11ProMaxFourteenScreen> {
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
                      _buildGroup413(context),
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
                  child: Text("msg_choose_the_days".tr,
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
        child: Consumer<Iphone11ProMaxFourteenProvider>(
            builder: (context, provider, child) {
          return provider.iphone11ProMaxFourteenModelObj!.radioList.isNotEmpty
              ? Column(children: [
                  Padding(
                      padding: EdgeInsets.only(right: 34.h),
                      child: CustomRadioButton(
                          text: "lbl_sunday".tr,
                          value: provider.iphone11ProMaxFourteenModelObj
                                  ?.radioList[0] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 25.v, right: 28.h),
                      child: CustomRadioButton(
                          text: "lbl_monday".tr,
                          value: provider.iphone11ProMaxFourteenModelObj
                                  ?.radioList[1] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 25.v, right: 26.h),
                      child: CustomRadioButton(
                          text: "lbl_tuesday".tr,
                          value: provider.iphone11ProMaxFourteenModelObj
                                  ?.radioList[2] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 25.v),
                      child: CustomRadioButton(
                          text: "lbl_wednesday".tr,
                          value: provider.iphone11ProMaxFourteenModelObj
                                  ?.radioList[3] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 25.v, right: 18.h),
                      child: CustomRadioButton(
                          text: "lbl_thursday".tr,
                          value: provider.iphone11ProMaxFourteenModelObj
                                  ?.radioList[4] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 26.v, right: 44.h),
                      child: CustomRadioButton(
                          text: "lbl_friday".tr,
                          value: provider.iphone11ProMaxFourteenModelObj
                                  ?.radioList[5] ??
                              "",
                          groupValue: provider.radioGroup,
                          onChange: (value) {
                            provider.changeRadioButton1(value);
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 26.v, right: 22.h),
                      child: CustomRadioButton(
                          text: "lbl_saturday".tr,
                          value: provider.iphone11ProMaxFourteenModelObj
                                  ?.radioList[6] ??
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

  /// Navigates to the iphone11ProMaxThirteenScreen when the action is triggered.
  onTapImgArrowDown(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxThirteenScreen,
    );
  }

  /// Navigates to the timeofdayScreen when the action is triggered.
  onTapNext(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.timeofdayScreen,
    );
  }
}
