import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Medication {
  // todo - Cons: Upon restart this will be set back to 0
  static int _globalNotificationIdCounter = 1;

  final List<int> notificationIdList = [_globalNotificationIdCounter];
  final String name;
  final String type;
  final String betweenMeals;
  final List<DateTime?> scheduledTimeList;  // todo make it a Map<DateTime?, List<int>>
  final IconData icon;

  Medication({
    required this.name,
    required this.type,
    required this.icon,
    required this.betweenMeals,
    required this.scheduledTimeList,
  }) {
    _globalNotificationIdCounter += 100;
  }

  Future<void> saveAndIncrementGlobalNotificationIdCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('medicationIdCounter', Medication._globalNotificationIdCounter);
    _globalNotificationIdCounter++;
  }

  void appendNotificationId() {
    notificationIdList.add(notificationIdList.last + 1);
  }

  // todo Yiannis upgrade this according to the List<DateTime>
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'betweenMeals': betweenMeals,
      'scheduledTimeList': scheduledTimeList
          .map((dateTime) => dateTime?.millisecondsSinceEpoch)
          .toList(),
    };
  }
}
