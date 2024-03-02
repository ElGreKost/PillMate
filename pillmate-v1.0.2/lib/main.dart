import 'package:flutter/material.dart';
import 'core/app_export.dart';
import 'package:provider/provider.dart';
import 'backend/app_state.dart'; // Make sure to import your NavigationModel file

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Used for QueryData or whatever it's called

  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: theme,
            title: 'pillmate',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.homescreenPage,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
