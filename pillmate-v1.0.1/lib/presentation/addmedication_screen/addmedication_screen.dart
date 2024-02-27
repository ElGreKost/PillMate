import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pillmate/widgets/custom_text_form_field.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'models/addmedication_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/addmedication_provider.dart';

class AddmedicationScreen extends StatefulWidget {
  const AddmedicationScreen({Key? key}) : super(key: key);

  @override
  AddmedicationScreenState createState() => AddmedicationScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddmedicationProvider(),
        child: AddmedicationScreen());
  }
}

// ignore_for_file: must_be_immutable
class AddmedicationScreenState extends State<AddmedicationScreen> {
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
                padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 30.v),
                child: Column(children: [
                  _buildArrowDown(context),
                  SizedBox(height: 48.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.h),
                      child: Selector<AddmedicationProvider,
                              TextEditingController?>(
                          selector: (context, provider) =>
                              provider.editTextController,
                          builder: (context, editTextController, child) {
                            return CustomTextFormField(
                                controller: editTextController,
                                textInputAction: TextInputAction.done);
                          })),
                  SizedBox(height: 8.v),
                  SizedBox(
                      height: 17.v,
                      width: 246.h,
                      child: Stack(alignment: Alignment.center, children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text("msg_type_and_choose".tr,
                                style: theme.textTheme.bodyMedium)),
                        Align(
                            alignment: Alignment.center,
                            child: Text("msg_type_and_choose".tr,
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
}
