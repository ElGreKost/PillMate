import 'package:flutter/cupertino.dart';

class Medication {
  final String name;
  final String kind;
  final List<String> specificDays;
  final String betweenMeals;
  final DateTime scheduledTime;
  final IconData icon;

  Medication({
    required this.name,
    required this.kind,
    required this.icon,
    required this.specificDays,
    required this.betweenMeals,
    required this.scheduledTime, // Optional food instruction
  });
}
