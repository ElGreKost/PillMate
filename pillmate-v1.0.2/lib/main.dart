import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'backend/notification_controller.dart';
import 'core/app_export.dart';
import 'package:provider/provider.dart';
import 'backend/app_state.dart';
import 'services/medication_data_provider.dart'; // Make sure to import your NavigationModel file
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pillmate/services/personal_data.dart';

Future<void> deleteAllUserData() async {
  try {
    final Box userDataBox = await Hive.openBox('userdata');
    await userDataBox.clear();
    print('All data deleted from the userdata box.');
  } catch (e) {
    print('Error deleting data from the userdata box: $e');
  }
}


Future<void> deleteMedicationWithName(String name) async {
  final Box medicationsBox = Hive.box('medications');

  // Iterate over the items in the box
  for (var key in medicationsBox.keys) {
    dynamic data = medicationsBox.get(key);

    // Check if the item is a Map<dynamic, dynamic>
    if (data is Map<dynamic, dynamic>) {
      // Check if the name matches
      if (data['name'] == name) {
        // Delete the item from the box
        await medicationsBox.delete(key);
        print('Medication with name $name deleted successfully!');
        return; // Exit the function after deleting the medication
      }
    }
    else print('type is: ${data.runtimeType}');
  }

  // If no medication with the specified name is found
  print('Medication with name $name not found in the box.');
}

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
  await Hive.openBox('userdata');

  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: 'AIzaSyAhPiPIzLiVkXh9VJA1d-lJCgQE3pKg4eg',
      appId: '1:666763914566:android:89b2cbe4c5eeb2d4b00947',
      messagingSenderId: '666763914566',
      projectId: 'pillmate-4d684'));

  await AwesomeNotifications().initialize(
    // 'resource://drawable/ic_launcher',
      null, // to see pillmate icon
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: 'basic_channel_group', channelGroupName: 'Basic group')
      ],
      debug: true);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // todo make this beautiful
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // With the navigator key, you can redirect pages and get context even inside static classes.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool isFirstVisit = true;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod);

    super.initState();
    _checkFirstVisit();
  }

  Future<void> _checkFirstVisit() async {
    final prefs = await SharedPreferences.getInstance();
    widget.isFirstVisit = prefs.getBool('isFirstVisit') ?? true;

    if (widget.isFirstVisit) {
      await prefs.setBool('isFirstVisit', false);
      widget.isFirstVisit = false;
    }
  }


  @override
  Widget build(BuildContext context) {



    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => AppState()),
        ChangeNotifierProvider(create: (BuildContext context) => MedicationProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => UserDataProvider())
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: theme,
            title: 'pillmate',
            debugShowCheckedModeBanner: false,
            initialRoute: widget.isFirstVisit ? AppRoutes.onboardingScreen : AppRoutes.homescreenPage,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}