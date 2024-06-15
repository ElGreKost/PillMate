import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../../../services/medication.dart';
import '../theme/theme_helper.dart';

class NotificationUtils {
  static void scheduleMedicationNotifications(Medication med) {
    void scheduleNotification(DateTime notificationTime, String message) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: med.notificationIdList.last,
            channelKey: 'basic_channel',
            actionType: ActionType.Default,
            title: '${med.name} Time',
            body: message,
            groupKey: 'basic_channel_group'),
        actionButtons: [
          NotificationActionButton(
            key: 'MARK_TAKEN',
            label: 'Mark as Taken',
            actionType: ActionType.Default,
            color: appTheme.teal500,
          ),
        ],
        schedule: NotificationCalendar.fromDate(date: notificationTime),
      );
      med.appendNotificationId();
    }

    /// Creates a notification for each time in the scheduledTimes map
    med.scheduledTimes.forEach((day, times) {
      for (var time in times) {
        // Convert TimeOfDay to DateTime
        DateTime now = DateTime.now();
        DateTime notificationTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

        // Adjust notification time for each day
        switch (day) {
          case "Monday":
            notificationTime = notificationTime.add(Duration(days: (1 - now.weekday) % 7));
            break;
          case "Tuesday":
            notificationTime = notificationTime.add(Duration(days: (2 - now.weekday) % 7));
            break;
          case "Wednesday":
            notificationTime = notificationTime.add(Duration(days: (3 - now.weekday) % 7));
            break;
          case "Thursday":
            notificationTime = notificationTime.add(Duration(days: (4 - now.weekday) % 7));
            break;
          case "Friday":
            notificationTime = notificationTime.add(Duration(days: (5 - now.weekday) % 7));
            break;
          case "Saturday":
            notificationTime = notificationTime.add(Duration(days: (6 - now.weekday) % 7));
            break;
          case "Sunday":
            notificationTime = notificationTime.add(Duration(days: (7 - now.weekday) % 7));
            break;
        }

        // Schedule notifications
        scheduleNotification(notificationTime.subtract(Duration(minutes: 10)), 'Take your ${med.type} in 10 minutes.');
        scheduleNotification(notificationTime, 'It\'s time for your medication');
        scheduleNotification(notificationTime.add(Duration(minutes: 10)), 'Your ${med.type} should be taken before 10 minutes.');
      }
    });

    print(med.notificationIdList);
  }

  static void cancelAllMedicationNotifications(Medication med) {
    med.notificationIdList.forEach(
            (notificationId) => AwesomeNotifications().cancel(notificationId));
  }

  static void cancelTodayMedicationNotifications(Medication med) {
    String today = _dayOfWeek(DateTime.now().weekday);
    List<TimeOfDay>? times = med.scheduledTimes[today];

    if (times != null) {
      int todayIdx = DateTime.now().weekday - 1; // 0 for Monday, 1 for Tuesday, etc.
      int medActiveTimesNb = times.length;

      for (int iTimeIdx = 0; iTimeIdx < medActiveTimesNb; iTimeIdx++) {
        List<int> todayNotificationIdxList = [
          3 * (todayIdx * medActiveTimesNb + iTimeIdx),
          3 * (todayIdx * medActiveTimesNb + iTimeIdx) + 1,
          3 * (todayIdx * medActiveTimesNb + iTimeIdx) + 2
        ];
        todayNotificationIdxList.forEach(
                (idx) => AwesomeNotifications().cancel(med.notificationIdList[idx]));
      }
    }
  }

  static String _dayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
