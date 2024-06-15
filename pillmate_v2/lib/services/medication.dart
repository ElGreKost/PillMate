import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Medication {
  static int _globalNotificationIdCounter = 1;

  final List<int> notificationIdList = [_globalNotificationIdCounter];
  final String name;
  final String type;
  final String betweenMeals;
  final Map<String, List<TimeOfDay>> scheduledTimes; // Key: Day name, Value: List of times
  final IconData icon;
  final DateTime? repeatUntil; // The date until the medication is repeated

  Medication({
    required this.name,
    required this.type,
    required this.icon,
    required this.betweenMeals,
    required this.scheduledTimes,
    required this.repeatUntil,
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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'betweenMeals': betweenMeals,
      'scheduledTimes': scheduledTimes.map((day, times) => MapEntry(day, times.map((time) => '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}').toList())),
      'repeatUntil': repeatUntil?.millisecondsSinceEpoch,
    };
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      name: map['name'],
      type: map['type'],
      icon: Icons.medication, // Assuming a default icon, adjust as needed
      betweenMeals: map['betweenMeals'],
      scheduledTimes: (map['scheduledTimes'] as Map<String, dynamic>).map(
            (day, times) => MapEntry(
          day,
          (times as List<dynamic>).map((time) {
            final timeParts = (time as String).split(':');
            return TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
          }).toList(),
        ),
      ),
      repeatUntil: map['repeatUntil'] != null ? DateTime.fromMillisecondsSinceEpoch(map['repeatUntil']) : null,
    );
  }
}
