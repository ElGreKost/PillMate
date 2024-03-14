import 'package:flutter/cupertino.dart';

class Medication {
  static int _idCounter = 0;  // todo - Cons: Upon restart this will be set back to 0

  final int notificationId;
  final String name;
  final String kind;
  final List<String> specificDays;
  final String betweenMeals;
  final DateTime scheduledTime;
  final IconData icon;

  // Constructor with named parameters, automatically assigns an ID
  Medication({
    required this.name,
    required this.kind,
    required this.icon,
    required this.specificDays,
    required this.betweenMeals,
    required this.scheduledTime,
  }) : notificationId = ++_idCounter;
}
