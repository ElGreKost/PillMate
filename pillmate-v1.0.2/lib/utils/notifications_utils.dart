import 'package:awesome_notifications/awesome_notifications.dart';

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

    /// Creates a single for each active day
    List<DateTime?> scheduledTimeList = med.scheduledTimeList;
    for (DateTime? scheduledTime
        in scheduledTimeList.where((time) => time != null)) {
      // Something magical happens here and because of this print and the fact
      // that it has the ! (bang operator), the scheduledTime can be used for
      // scheduling the notificationTime values
      print(scheduledTime!); // todo never delete this print
      scheduleNotification(scheduledTime.subtract(Duration(minutes: 10)),
          'Take your ${med.type} in 10 minutes.');
      scheduleNotification(scheduledTime, 'It\'s time for your medication');
      scheduleNotification(scheduledTime.add(Duration(minutes: 10)),
          'Your ${med.type} should be taken before 10 minutes.');
    }
    print(med.notificationIdList);
  }

  static void cancelMedicationNotifications(Medication med) {
    med.notificationIdList.forEach(
        (notificationId) => AwesomeNotifications().cancel(notificationId));
  }
}
// todo change launch therapy
