import 'package:flutter/material.dart';
import 'core/app_export.dart';
import 'package:provider/provider.dart';
import 'backend/app_state.dart';
import 'services/medication_data_provider.dart'; // Make sure to import your NavigationModel file
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


Future<String> _getHiveStorageDirectory() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  return appDocDir.path;
}

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Used for QueryData or whatever it's called

  String hiveStorageDirectory = await _getHiveStorageDirectory();

  print('directory to store is $hiveStorageDirectory');

  await Hive.initFlutter(hiveStorageDirectory);

  await Hive.openBox('medications');

  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => AppState()),
        ChangeNotifierProvider(create: (BuildContext context) => MedicationProvider()),
      ],
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
