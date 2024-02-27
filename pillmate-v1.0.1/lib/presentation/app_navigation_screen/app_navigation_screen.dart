import 'models/app_navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/app_navigation_provider.dart';

class AppNavigationScreen extends StatefulWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  AppNavigationScreenState createState() => AppNavigationScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppNavigationProvider(),
      child: AppNavigationScreen(),
    );
  }
}

class AppNavigationScreenState extends State<AppNavigationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Homescreen - Container".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.homescreenContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "AddMedication".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.addmedicationScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Three".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.iphone11ProMaxThreeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Five".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.iphone11ProMaxFiveScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Frequency".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.frequencyScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "ChooseDay".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.choosedayScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "TimeOfDay".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.timeofdayScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "SetTime".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.settimeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "PickAudio".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.pickaudioScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "AddPill".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.addpillScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Thirty".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.iphone11ProMaxThirtyScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Thirteen".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.iphone11ProMaxThirteenScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Settings".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.settingsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Six".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.iphone11ProMaxSixScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Fourteen".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.iphone11ProMaxFourteenScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Sixteen".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.iphone11ProMaxSixteenScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(String routeName) {
    NavigatorService.pushNamed(routeName);
  }
}
