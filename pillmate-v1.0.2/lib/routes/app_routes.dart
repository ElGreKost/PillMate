import 'package:flutter/material.dart';
import 'package:pillmate/presentation/homescreen_page/homescreen_page.dart';
import 'package:pillmate/presentation/onboarding_screen/onboarding_screen.dart';
import '../presentation/plan_medication/plan_medication.dart';
import '../presentation/select_medication_type_screen/select_medication_type_screen.dart';
import '../presentation/select_pill_name/select_pill_name.dart';
import '../presentation/settings_screen/settings_screen.dart';

class AppRoutes {
  static const String onboardingScreen = '/onboarding_screen';

  static const String homescreenPage = '/homescreen_page';

  static const String modernSelectDay = '/modern_select_day';

  static const String selectPillName = '/select_pill_name';
  static const String settingsScreen = '/settings_screen';

  static const String selectMedicationTypeScreen = '/select_medication_type_screen';


  static Map<String, WidgetBuilder> routes = {
    onboardingScreen: (context) => OnboardingScreen(),
    homescreenPage: (context) => HomescreenPage(),
    selectMedicationTypeScreen: (context) => SelectMedicationTypeScreen(),
    settingsScreen: (context) => SettingsScreen(),
    selectPillName: (context) => SelectPillName(),
    modernSelectDay: (context) => PlanMedicationScreen(),
  };
}
