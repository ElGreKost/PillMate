import 'package:flutter/material.dart';
import '../presentation/homescreen_container_screen/homescreen_container_screen.dart';
import '../presentation/addmedication_screen/addmedication_screen.dart';
import '../presentation/iphone_11_pro_max_three_screen/iphone_11_pro_max_three_screen.dart';
import '../presentation/iphone_11_pro_max_five_screen/iphone_11_pro_max_five_screen.dart';
import '../presentation/frequency_screen/frequency_screen.dart';
import '../presentation/chooseday_screen/chooseday_screen.dart';
import '../presentation/timeofday_screen/timeofday_screen.dart';
import '../presentation/settime_screen/settime_screen.dart';
import '../presentation/pickaudio_screen/pickaudio_screen.dart';
import '../presentation/addpill_screen/addpill_screen.dart';
import '../presentation/iphone_11_pro_max_thirty_screen/iphone_11_pro_max_thirty_screen.dart';
import '../presentation/iphone_11_pro_max_thirteen_screen/iphone_11_pro_max_thirteen_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/iphone_11_pro_max_six_screen/iphone_11_pro_max_six_screen.dart';
import '../presentation/iphone_11_pro_max_fourteen_screen/iphone_11_pro_max_fourteen_screen.dart';
import '../presentation/iphone_11_pro_max_sixteen_screen/iphone_11_pro_max_sixteen_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String homescreenContainerScreen =
      '/homescreen_container_screen';

  static const String homescreenPage = '/homescreen_page';

  static const String addmedicationScreen = '/addmedication_screen';

  static const String iphone11ProMaxThreeScreen =
      '/iphone_11_pro_max_three_screen';

  static const String iphone11ProMaxFiveScreen =
      '/iphone_11_pro_max_five_screen';

  static const String frequencyScreen = '/frequency_screen';

  static const String choosedayScreen = '/chooseday_screen';

  static const String timeofdayScreen = '/timeofday_screen';

  static const String settimeScreen = '/settime_screen';

  static const String pickaudioScreen = '/pickaudio_screen';

  static const String addpillScreen = '/addpill_screen';

  static const String iphone11ProMaxThirtyScreen =
      '/iphone_11_pro_max_thirty_screen';

  static const String iphone11ProMaxTwentysixPage =
      '/iphone_11_pro_max_twentysix_page';

  static const String iphone11ProMaxThirteenScreen =
      '/iphone_11_pro_max_thirteen_screen';

  static const String settingsScreen = '/settings_screen';

  static const String iphone11ProMaxSixScreen = '/iphone_11_pro_max_six_screen';

  static const String iphone11ProMaxFourteenScreen =
      '/iphone_11_pro_max_fourteen_screen';

  static const String iphone11ProMaxSixteenScreen =
      '/iphone_11_pro_max_sixteen_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    homescreenContainerScreen: (context) => HomescreenContainerScreen(),
    addmedicationScreen: (context) => AddmedicationScreen(),
    iphone11ProMaxThreeScreen: (context) => Iphone11ProMaxThreeScreen(),
    iphone11ProMaxFiveScreen: (context) => Iphone11ProMaxFiveScreen(),
    frequencyScreen: (context) => FrequencyScreen(),
    choosedayScreen: (context) => ChoosedayScreen(),
    timeofdayScreen: (context) => TimeofdayScreen(),
    settimeScreen: (context) => SettimeScreen(),
    pickaudioScreen: (context) => PickaudioScreen(),
    addpillScreen: (context) => AddpillScreen(),
    iphone11ProMaxThirtyScreen: (context) => Iphone11ProMaxThirtyScreen(),
    iphone11ProMaxThirteenScreen: (context) => Iphone11ProMaxThirteenScreen(),
    settingsScreen: (context) => SettingsScreen(),
    iphone11ProMaxSixScreen: (context) => Iphone11ProMaxSixScreen(),
    iphone11ProMaxFourteenScreen: (context) => Iphone11ProMaxFourteenScreen(),
    iphone11ProMaxSixteenScreen: (context) => Iphone11ProMaxSixteenScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
