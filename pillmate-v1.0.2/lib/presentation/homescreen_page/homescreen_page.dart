import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/widgets/app_bar/appbar_title_button.dart';
import '../../services/medication.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/med_list_tile.dart';
import '../pickaudio_screen/pickaudio_screen.dart';

class HomescreenPage extends StatelessWidget {
  const HomescreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 49.h,
          backgroundColor: appTheme.grey900,
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settingsScreen),
            icon: Icon(Icons.settings, color: appTheme.cyan500),
          ),
          centerTitle: true,
          title: AppbarTitleButton(),
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) => SizedBox(height: 340.h, child: AudioBottomSheet()),
              ),
              icon: Icon(Icons.campaign_outlined, color: appTheme.cyan500, size: 35.h),
            )
          ],
        ),
        body: _buildMedList(context),
        // bottomNavigationBar: GNavWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.selectPillName),
          child: Icon(Icons.add, color: Colors.white, size: 35.v),
          backgroundColor: appTheme.cyan500,
        ),
      ),
    );
  }

  Widget _buildMedList(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('medications').listenable(),
      builder: (context, box, _) {
        List<Medication> medications = _getAllMedications(box);
        print('All medications:');
        medications.forEach((medication) {
          print(medication.name);
          print('Scheduled timelist is: ${medication.scheduledTimeList}');
        }
        );print('finished with meds');

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 4.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Good Morning \n", style: CustomTextStyles.titleLargeffffffff),
                    TextSpan(text: "Gracy", style: theme.textTheme.displaySmall),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              CustomElevatedButton(
                text: 'Notification',
                onPressed: () => createPillReminderNotification(10, 'DepoNaki'),
              ),
              SizedBox(height: 8),
              SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 40.v),
                  itemCount: medications.length,
                  itemBuilder: (context, index) => MedListTile(medication: medications[index]),
                ),
              ),
              SizedBox(height: 20.v),
            ],
          ),
        );
      },
    );
  }

  // Define a function to create a customized notification
  void createPillReminderNotification(int notificationId, String medicationName) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'basic_channel', // Make sure this channel is defined in your AwesomeNotifications initialization
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
          final List<dynamic>? timestampList = data['scheduledTimes'] as List<dynamic>?;

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
          icon: Icons.access_alarm, // You might need to set this appropriately based on your data
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
