import 'package:flutter/cupertino.dart';

class Medication {
  static int _idCounter =
      1; // todo - Cons: Upon restart this will be set back to 0

  final int notificationId=_idCounter;
  final String name;
  final String type;
  final String betweenMeals;
  final List<DateTime?> scheduledTimeList;
  final IconData icon;

  Medication({
    required this.name,
    required this.type,
    required this.icon,
    required this.betweenMeals,
    required this.scheduledTimeList,
  }) {
    _idCounter = _idCounter + 3;
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
