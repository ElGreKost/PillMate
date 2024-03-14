import 'package:flutter/cupertino.dart';


class Medication {
  final String name;
  final String type;
  final List<String> days;
  final String betweenMeals;
  final DateTime exactTime;
  final IconData icon;

  Medication({
    required this.name,
    required this.type,
    required this.icon,
    required this.days,
    required this.betweenMeals,
    required this.exactTime, // Optional food instruction
  });





  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'days': days,
      'betweenMeals': betweenMeals,
      'exactTime': exactTime.toString(), // Convert DateTime to String
    };
  }
}
