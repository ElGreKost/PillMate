import 'package:awesome_notifications/awesome_notifications.dart';

import '../../../services/medication.dart';
import '../theme/theme_helper.dart';

class NotificationUtils {
  static void scheduleMedicationNotifications(Medication med) {
    // Helper function to schedule a notification
    void scheduleNotification(
        {required int notificationId,
        required bool isLate,
        required Duration timeInterval,
        required String messageSuffix}) {
      List<DateTime?> scheduledTimeList = med.scheduledTimeList;
      for (DateTime? scheduledTime
          in scheduledTimeList.where((time) => time != null)) {
        // Something magical happens here and because of this print and the fact
        // that it has the ! (bang operator), the scheduledTime can be used for
        // scheduling the notificationTime values
        print(scheduledTime!); // todo never delete this print

        DateTime notificationTime = isLate
            ? scheduledTime.add(timeInterval)
            : scheduledTime.subtract(timeInterval);
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId,
              // giving the same id to all isn't the best of ideas as it seems
              // Ensure this ID is unique for each notification
              channelKey: 'basic_channel',
              actionType: ActionType.Default,
              title: '${med.name} Time',
              body: 'Time to take your ${med.type}. $messageSuffix',
              groupKey: 'basic_channel_group'),

          actionButtons: [
            NotificationActionButton(
              key: 'MARK_TAKEN',
              label: 'Mark as Taken',
              actionType: ActionType.Default,
              color: appTheme.teal500,
              // buttonType: ActionButtonType.Default,
            ),
          ],
          schedule: NotificationCalendar.fromDate(date: notificationTime),
        );
      }
    }

    print('Now starting to set notifications for ${med.name}');
    int notificationId = med.notificationId;
    scheduleNotification(
      notificationId: notificationId++,
        isLate: false,
        timeInterval: Duration(minutes: 10),
        messageSuffix: 'Scheduled in 10 minutes.');
    print(notificationId);
    scheduleNotification(
        notificationId: notificationId++,
        isLate: false,
        timeInterval: Duration.zero,
        messageSuffix: 'It\'s time for your medication');
    print(notificationId);
    scheduleNotification(
        notificationId: notificationId++,
        isLate: true,
        timeInterval: Duration(minutes: 10),
        messageSuffix: 'Scheduled before 10 minutes.');
    print(notificationId);
  }

  static void cancelMedicationNotifications(Medication med) {
    AwesomeNotifications().cancel(med.notificationId);
    AwesomeNotifications().cancel(med.notificationId + 1);
    AwesomeNotifications().cancel(med.notificationId + 2);
  }
}
