import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_routes.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstVisitAndNavigate();

  }

  Future<void> _checkFirstVisitAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstVisit = prefs.getBool('isFirstVisit') ?? true;

    // After checking, navigate to the appropriate screen
    if (isFirstVisit) {
      // Update the preference to indicate it's no longer the first visit
      await prefs.setBool('isFirstVisit', false);
      Navigator.pushNamed(context, AppRoutes.onboardingScreen);
    } else {
      Navigator.pushNamed(context, AppRoutes.homescreenPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Optionally show a loading indicator
      ),
    );
  }
}
