import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_text_form_field.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'models/iphone_11_pro_max_thirty_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/iphone_11_pro_max_thirty_provider.dart';

class Iphone11ProMaxThirtyScreen extends StatefulWidget {
  const Iphone11ProMaxThirtyScreen({Key? key}) : super(key: key);

  @override
  Iphone11ProMaxThirtyScreenState createState() =>
      Iphone11ProMaxThirtyScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Iphone11ProMaxThirtyProvider(),
        child: Iphone11ProMaxThirtyScreen());
  }
}

// ignore_for_file: must_be_immutable
class Iphone11ProMaxThirtyScreenState
    extends State<Iphone11ProMaxThirtyScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 30.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildArrowDown(context),
                      SizedBox(height: 48.v),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.h),
                          child: Selector<Iphone11ProMaxThirtyProvider,
                                  TextEditingController?>(
                              selector: (context, provider) =>
                                  provider.rinController,
                              builder: (context, rinController, child) {
                                return CustomTextFormField(
                                    controller: rinController,
                                    hintText: "lbl_rin".tr,
                                    textInputAction: TextInputAction.done);
                              })),
                      SizedBox(height: 34.v),
                      _buildTwo(context),
                      SizedBox(height: 2.v)
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
            padding: EdgeInsets.only(left: 13.h, right: 57.h),
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
                      width: 299.h,
                      margin: EdgeInsets.only(left: 9.h, top: 4.v),
                      child: Text("msg_what_medicine_do".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall)))
            ])));
  }

  /// Section Widget
  Widget _buildTwo(BuildContext context) {
    return Container(
        width: 413.h,
        margin: EdgeInsets.only(left: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 37.h, vertical: 41.v),
        decoration: AppDecoration.outlineBlack9001,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    onTapTxtRivoq(context);
                  },
                  child:
                      Text("lbl_rivoq".tr, style: theme.textTheme.bodyLarge)),
              SizedBox(height: 19.v),
              Text("lbl_rinnovi".tr, style: theme.textTheme.bodyLarge),
              SizedBox(height: 19.v)
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

  /// Navigates to the iphone11ProMaxThreeScreen when the action is triggered.
  onTapImgArrowDown(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxThreeScreen,
    );
  }

  /// Navigates to the iphone11ProMaxThreeScreen when the action is triggered.
  onTapTxtRivoq(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxThreeScreen,
    );
  }
}
