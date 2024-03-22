import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/widgets/app_bar/appbar_title_button.dart';
import '../../services/medication.dart';
import '../../widgets/med_list_tile.dart';
import '../pickaudio_screen/pickaudio_screen.dart';

Future<String?> getNameFromUserData() async {
  try {
    final Box userDataBox = await Hive.openBox('userdata');
    Map<dynamic, dynamic>? userData = userDataBox.values.first;

    if (userData != null) {
      String? name = userData['name'];
      return name;
    } else {
      print('No data available in the userdata box.');
      return null;
    }
  } catch (e) {
    print('Error retrieving name from userdata box: $e');
    return null;
  }
}



class HomescreenPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 49.h,
          backgroundColor: appTheme.grey900,
          foregroundColor: appTheme.grey900,
          leading: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.settingsScreen),
            icon: Icon(Icons.settings, color: appTheme.cyan500),
          ),
          centerTitle: true,
          title: AppbarTitleButton(),
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) =>
                    SizedBox(height: 340.h, child: AudioBottomSheet()),
              ),
              icon: Icon(Icons.campaign_outlined,
                  color: appTheme.cyan500, size: 35.h),
            )
          ],
        ),
        body: _buildMedList(context),
        // bottomNavigationBar: GNavWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.selectPillName),
          child: Icon(Icons.add, color: Colors.white, size: 35.v),
          backgroundColor: appTheme.cyan500,
        ),
      ),
    );
  }

  // void _showWelcomeDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Welcome to PillMate!'),
  //       content: Text('Would you like to personalize your experience?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: Text('No'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop(); // Close the dialog
  //             _showPersonalizationForm(); // Proceed to the form
  //           },
  //           child: Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // void _showPersonalizationForm() {
  //   // Navigate to a new screen or show a modal to collect more details
  //   // For simplicity, let's show another dialog for now
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Personalize Your Experience'),
  //       content: SingleChildScrollView(
  //         child: ListBody(
  //           children: [
  //             TextField(
  //               decoration: InputDecoration(labelText: 'Your Name'),
  //             ),
  //             TextField(
  //               decoration: InputDecoration(labelText: 'Loved One\'s Name'),
  //             ),
  //             TextField(
  //               decoration:
  //               InputDecoration(labelText: 'Loved One\'s Phone Number'),
  //             ),
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: Text('Submit'),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  Widget _buildMedList(BuildContext context) {
    return FutureBuilder<String?>(
      future: getNameFromUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator or placeholder widget while waiting for the result
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Return an error message widget if an error occurs
          return Text('Error: ${snapshot.error}');
        } else {
          // Retrieve the user name from the snapshot data
          String userName = snapshot.data ?? 'User';
          // Continue building the UI with the retrieved user name
          return ValueListenableBuilder<Box>(
            valueListenable: Hive.box('medications').listenable(),
            builder: (context, box, _) {
              List<Medication> medications = _getAllMedications(box);

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 4.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Good Morning \n",
                            style: CustomTextStyles.titleLargeffffffff,
                          ),
                          TextSpan(text: userName, style: theme.textTheme.displayMedium)
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: 40.v),
                        itemCount: medications.length,
                        itemBuilder: (context, index) =>
                            MedListTile(medication: medications[index]),
                      ),
                    ),
                    SizedBox(height: 20.v),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }


  // Define a function to create a customized notification
  void createPillReminderNotification(
      int notificationId, String medicationName) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'basic_channel',
        // Make sure this channel is defined in your AwesomeNotifications initialization
        title: '$medicationName Time',
        body: 'Time to take your $medicationName.',
        actionType: ActionType.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_TAKEN',
          label: 'Mark as Taken',
          actionType: ActionType.Default,
          color: appTheme.teal500,
          // buttonType: ActionButtonType.Default,
        ),
      ],
    );
  }

  List<Medication> _getAllMedications(Box box) {
    List<Medication> allMedications = [];

    for (var key in box.keys) {
      dynamic data = box.get(key);

      if (data is Map<dynamic, dynamic>) {
        List<DateTime?> retrieveDateTimeList(Map<dynamic, dynamic> data) {
          final List<dynamic>? timestampList =
              data['scheduledTimes'] as List<dynamic>?;

          if (timestampList == null) return [];

          return timestampList.map((dynamic timestamp) {
            if (timestamp is int) {
              return DateTime.fromMillisecondsSinceEpoch(timestamp);
            } else {
              return null; // Or any other appropriate action
            }
          }).toList();
        }

        print('data printed is: ${data['name']}');
        Medication medication = Medication(
          name: data['name'] ?? '',
          type: data['type'] ?? '',
          betweenMeals: data['betweenMeals'] ?? '',
          // scheduledTimeList: data['scheduleTimes'] != null ? DateTime.parse(data['exactTime']) : DateTime.now(),
          scheduledTimeList: retrieveDateTimeList(data),
          icon: Icons
              .access_alarm, // You might need to set this appropriately based on your data
        );
        allMedications.add(medication);
        print('finished');
      } else {
        print(data.runtimeType);
      }
    }
    return allMedications;
  }
}
