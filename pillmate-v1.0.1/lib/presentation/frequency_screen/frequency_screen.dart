import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/frequency_item_widget.dart';
import 'models/frequency_item_model.dart';
import 'models/frequency_model.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/frequency_provider.dart';

class FrequencyScreen extends StatefulWidget {
  const FrequencyScreen({Key? key}) : super(key: key);

  @override
  FrequencyScreenState createState() => FrequencyScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FrequencyProvider(), child: FrequencyScreen());
  }
}

// ignore_for_file: must_be_immutable
class FrequencyScreenState extends State<FrequencyScreen> {
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
                      _buildFrequency(context)
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
              height: 58.v,
              width: 286.h,
              margin: EdgeInsets.only(left: 15.h, top: 3.v),
              child: Stack(alignment: Alignment.center, children: [
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 286.h,
                        child: Text("msg_how_often_do_you".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall))),
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 286.h,
                        child: Text("msg_how_often_do_you".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall)))
              ]))
        ]));
  }

  /// Section Widget
  Widget _buildFrequency(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 26.h, right: 209.h),
        child: Consumer<FrequencyProvider>(builder: (context, provider, child) {
          return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 24.v);
              },
              itemCount: provider.frequencyModelObj.frequencyItemList.length,
              itemBuilder: (context, index) {
                FrequencyItemModel model =
                    provider.frequencyModelObj.frequencyItemList[index];
                return FrequencyItemWidget(model, onTapView: () {
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

  /// Navigates to the iphone11ProMaxThirteenScreen when the action is triggered.
  onTapView(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxThirteenScreen,
    );
  }
}
