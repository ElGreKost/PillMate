import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/view_item_widget.dart';
import 'models/view_item_model.dart';
import 'models/iphone_11_pro_max_five_model.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/iphone_11_pro_max_five_provider.dart';

class Iphone11ProMaxFiveScreen extends StatefulWidget {
  const Iphone11ProMaxFiveScreen({Key? key}) : super(key: key);

  @override
  Iphone11ProMaxFiveScreenState createState() =>
      Iphone11ProMaxFiveScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Iphone11ProMaxFiveProvider(),
        child: Iphone11ProMaxFiveScreen());
  }
}

// ignore_for_file: must_be_immutable
class Iphone11ProMaxFiveScreenState extends State<Iphone11ProMaxFiveScreen> {
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
                      SizedBox(height: 78.v),
                      _buildView(context)
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
        title: AppbarTitle(text: "lbl_rinvoq".tr),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgUser,
              margin: EdgeInsets.fromLTRB(27.h, 18.v, 27.h, 13.v))
        ]);
  }

  /// Section Widget
  Widget _buildArrowDown(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 44.h),
        child: Row(children: [
          SizedBox(
              height: 36.adaptSize,
              width: 36.adaptSize,
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
              height: 29.v,
              width: 299.h,
              margin: EdgeInsets.only(left: 9.h, top: 4.v, bottom: 2.v),
              child: Stack(alignment: Alignment.center, children: [
                Align(
                    alignment: Alignment.center,
                    child: Text("msg_what_kind_of_medicine".tr,
                        style: theme.textTheme.headlineSmall)),
                Align(
                    alignment: Alignment.center,
                    child: Text("msg_what_kind_of_medicine".tr,
                        style: theme.textTheme.headlineSmall))
              ]))
        ]));
  }

  /// Section Widget
  Widget _buildView(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 18.h, right: 259.h),
        child: Consumer<Iphone11ProMaxFiveProvider>(
            builder: (context, provider, child) {
          return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 26.v);
              },
              itemCount:
                  provider.iphone11ProMaxFiveModelObj.viewItemList.length,
              itemBuilder: (context, index) {
                ViewItemModel model =
                    provider.iphone11ProMaxFiveModelObj.viewItemList[index];
                return ViewItemWidget(model, onTapView: () {
                  onTapView(context);
                });
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

  /// Navigates to the iphone11ProMaxSixScreen when the action is triggered.
  onTapView(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxSixScreen,
    );
  }
}
