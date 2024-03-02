import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/iphone_11_pro_max_twentysix_page/iphone_11_pro_max_twentysix_page.dart';
import 'package:pillmate/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

import '../../widgets/bottom_navigation_bar.dart';

// ignore_for_file: must_be_immutable
class HomescreenContainerScreen extends StatelessWidget {
  HomescreenContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // body: Navigator(
            //     key: navigatorKey,
            //     initialRoute: AppRoutes.homescreenPage,
            //     onGenerateRoute: (routeSetting) => PageRouteBuilder(
            //         pageBuilder: (ctx, ani, ani1) =>
            //             getCurrentPage(routeSetting.name!),
            //         transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: GNavWidget()
        )
    );
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
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homescreenPage:
        return HomescreenPage();
      case AppRoutes.iphone11ProMaxTwentysixPage:
        return Iphone11ProMaxTwentysixPage();
      default:
        return DefaultWidget();
    }
  }
}
