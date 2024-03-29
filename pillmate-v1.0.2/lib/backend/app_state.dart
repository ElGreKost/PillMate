import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../services/medication.dart';

class AppState with ChangeNotifier {
  int _navIdx = 0;
  String _activeRoute = AppRoutes.homescreenPage;
  List<String> navRoutes = [AppRoutes.homescreenPage, AppRoutes.settingsScreen];

  int get navIdx => _navIdx;

  String get activeRoute => _activeRoute;

  void setNavigatorIndex(int idx, BuildContext context) {
    _navIdx = idx;
    Navigator.of(context).pushNamed(_activeRoute);
    notifyListeners();
  }

  // For medication list
  List<Medication> medList = [
    Medication(name: 'DepoNaki', icon: Icons.water_drop, kind: 'pill', specificDays: ['Mon', 'Wed', 'Fri'], betweenMeals: 'Anytime', scheduledTime: DateTime.now().add(Duration(hours: 1, seconds: 10))),
    Medication(name: 'Depon', icon: Icons.water_drop, kind: 'pill', specificDays: ['Mon', 'Wed', 'Fri'], betweenMeals: 'Anytime', scheduledTime: DateTime.now().add(Duration(hours: 7))),
    Medication(name: 'Algofren', icon: Icons.water_drop, kind: 'pill', specificDays: ['Sat', 'Wed', 'Mon'], betweenMeals: 'Before food', scheduledTime: DateTime.now().add(Duration(hours: 8))),
    Medication(name: 'Ponstan', icon: Icons.water_drop, kind: 'pill', specificDays: ['Fri'], betweenMeals: 'Anytime', scheduledTime: DateTime.now().add(Duration(hours: 2))),
    Medication(name: 'Niflamol', icon: Icons.water_drop, kind: 'pill', specificDays: ['Everyday'], betweenMeals: 'Before food', scheduledTime: DateTime.now().add(Duration(hours: 7))),
    Medication(name: 'Depon', icon: Icons.water_drop, kind: 'pill', specificDays: ['Mon', 'Wed', 'Fri'], betweenMeals: 'Anytime', scheduledTime: DateTime.now().add(Duration(hours: 5))),
    Medication(name: 'Algofren', icon: Icons.water_drop, kind: 'pill', specificDays: ['Sat', 'Wed', 'Mon'], betweenMeals: 'Before food', scheduledTime: DateTime.now().add(Duration(hours: 1))),
  ];

  void addMedication(Medication med) {
    medList.add(med);
    notifyListeners();
  }
  
  void deleteMedication(Medication med) {
    medList.remove(med);
    notifyListeners();
  }
}


