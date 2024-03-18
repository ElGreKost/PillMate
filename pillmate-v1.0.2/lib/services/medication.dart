import 'package:flutter/cupertino.dart';


class Medication {
  static int _idCounter = 0;  // todo - Cons: Upon restart this will be set back to 0

  final int notificationId;
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
  }): notificationId = ++_idCounter;




  // todo Yiannis upgrade this according to the List<DateTime>
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'betweenMeals': betweenMeals,
      'scheduledTimeList': scheduledTimeList.map((dateTime) => dateTime?.millisecondsSinceEpoch).toList(),
    };
  }


}
