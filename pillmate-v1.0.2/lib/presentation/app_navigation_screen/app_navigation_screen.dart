import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

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
                          screenTitle: "Homescreen - Container",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.homescreenPage),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "AddMedication",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.addmedicationScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Three",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.iphone11ProMaxThreeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Five",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.iphone11ProMaxFiveScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Frequency",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.selectFrequencyScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "ChooseDay",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.chooseDayScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "TimeOfDay",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.timeofdayScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "SetTime",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.settimeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "AddPill",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.addpillScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Thirty",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.iphone11ProMaxThirtyScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Thirteen",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.iphone11ProMaxThirteenScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Settings",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.settingsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Six",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.iphone11ProMaxSixScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Fourteen",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.selectDayScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "iPhone 11 Pro Max - Sixteen",
                          onTapScreenTitle: () => onTapScreenTitle(context, AppRoutes.iphone11ProMaxSixteenScreen),
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
                "App Navigation",
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
                "Check your app's UI from the below demo screens of your app.",
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
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
