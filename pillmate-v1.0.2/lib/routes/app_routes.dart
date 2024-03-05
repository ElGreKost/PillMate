import 'package:flutter/material.dart';
import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import '../presentation/experimenting.dart';
import '../presentation/addmedication_screen/addmedication_screen.dart';
import '../presentation/iphone_11_pro_max_three_screen/iphone_11_pro_max_three_screen.dart';
import '../presentation/rinoq/iphone_11_pro_max_five_screen.dart';
import '../presentation/select_frequency_screen/select_frequency_screen.dart';
import '../presentation/chooseday_screen/chooseday_screen.dart';
import '../presentation/select_medication_type_screen/select_medication_type_screen.dart';
import '../presentation/select_pill_name/select_pill_name.dart';
import '../presentation/timeofday_screen/timeofday_screen.dart';
import '../presentation/settime_screen/settime_screen.dart';
import '../presentation/addpill_screen/addpill_screen.dart';
import '../presentation/iphone_11_pro_max_thirty_screen/iphone_11_pro_max_thirty_screen.dart';
import '../presentation/iphone_11_pro_max_thirteen_screen/iphone_11_pro_max_thirteen_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/select_day_screen/select_day_screen.dart';
import '../presentation/iphone_11_pro_max_sixteen_screen/iphone_11_pro_max_sixteen_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String homescreenPage = '/homescreen_page';

  static const String addmedicationScreen = '/addmedication_screen';

  static const String selectFrequencyScreen = '/select_frequency_screen';

  static const String selectPillName = '/select_pill_name';

  static const String iphone11ProMaxThreeScreen = '/iphone_11_pro_max_three_screen';

  static const String iphone11ProMaxFiveScreen = '/iphone_11_pro_max_five_screen';

  static const String chooseDayScreen = '/choose_day_screen';

  static const String timeofdayScreen = '/timeofday_screen';

  static const String settimeScreen = '/settime_screen';

  static const String addpillScreen = '/addpill_screen';

  static const String iphone11ProMaxThirtyScreen = '/iphone_11_pro_max_thirty_screen';

  static const String iphone11ProMaxTwentysixPage = '/iphone_11_pro_max_twentysix_page';

  static const String iphone11ProMaxThirteenScreen = '/iphone_11_pro_max_thirteen_screen';

  static const String settingsScreen = '/settings_screen';

  static const String iphone11ProMaxSixScreen = '/iphone_11_pro_max_six_screen';

  static const String selectDayScreen = '/select_day_screen';

  static const String selectMedicationTypeScreen = '/select_medication_type_screen';

  static const String iphone11ProMaxSixteenScreen = '/iphone_11_pro_max_sixteen_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String experimentingScreen = '/experimenting';

  static Map<String, WidgetBuilder> routes = {
    homescreenPage: (context) => HomescreenPage(),
    addmedicationScreen: (context) => AddmedicationScreen(),
    selectMedicationTypeScreen: (context) => SelectMedicationTypeScreen(),
    selectFrequencyScreen: (context) => SelectFrequencyScreen(),
    chooseDayScreen: (context) => ChoosedayScreen(),
    timeofdayScreen: (context) => TimeofdayScreen(),
    settimeScreen: (context) => SettimeScreen(),
    addpillScreen: (context) => AddpillScreen(),
    settingsScreen: (context) => SettingsScreen(),
    selectPillName: (context) => SelectPillName(),
    selectDayScreen: (context) => SelectDayScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    experimentingScreen: (context) => ExperimentingScreen(),
  };
}
