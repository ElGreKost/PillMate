import 'package:flutter/material.dart';
import 'backend/notification_controller.dart';
import 'core/app_export.dart';
import 'package:provider/provider.dart';
import 'backend/app_state.dart';
import 'services/medication_data_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Used for QueryData or whatever it's called

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

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }
}
