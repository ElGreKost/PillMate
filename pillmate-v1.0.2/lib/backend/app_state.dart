import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class AppState with ChangeNotifier {
  int _navIdx = 0;
  String _activeRoute = AppRoutes.homescreenPage;
  List<String> navRoutes = [AppRoutes.homescreenPage, AppRoutes.settingsScreen];

  var delete_me_github_test = 10;


  int get navIdx => _navIdx;
  String get activeRoute => _activeRoute;

  void setNavigatorIndex(int idx, BuildContext context) {
    _navIdx = idx;
    Navigator.of(context).pushNamed(_activeRoute);
    notifyListeners();
  }
}
