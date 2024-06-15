// tile_utils.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

TimeOfDay? findFirstNonNullTime(List<TimeOfDay?> times) {
  for (var time in times) {
    if (time != null) {
      return time;
    }
  }
  return null;
}

Future<String> searchMedication(String medName) async {
  try {
    CollectionReference medications =
        FirebaseFirestore.instance.collection('medications');
    DocumentSnapshot docSnapshot = await medications.doc(medName).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      data.remove('brand_name');

      String medicationData = 'Medication data for $medName:\n\n';
      data.forEach((key, value) {
        if (!(value is List && value.isEmpty)) {
          if (value is List) {
            if (value.first == '') value.removeAt(0);
            if (value.last == '') value.removeLast();
            String formattedValue = value.join('\n\n');
            medicationData += '$key:\n$formattedValue\n\n';
          }
        }
      });

      return medicationData;
    } else {
      return 'Medication not found: $medName';
    }
  } catch (error) {
    return 'Internet connection could not be established.\nPlease verify your network settings and try again.\nIf the problem persists, please provide further details at pillmateSupport@gmail.com.';
  }
}

IconData getIconForMedicationType(String type) {
  switch (type) {
    case 'Pill':
      return FontAwesomeIcons.pills;
    case 'Drink':
      return Ionicons.flask;
    case 'Injection':
      return FontAwesomeIcons.syringe;
    case 'Powder':
      return Icons.scatter_plot;
    case 'Drops':
      return Icons.water_drop;
    case 'Other':
      return Icons.medical_services;
    default:
      return Icons.error_outline;
  }
}


DateTime? findFirstScheduledTimeWithinNext12Hours(Map<String, List<TimeOfDay>> scheduledTimes) {
  final DateTime now = DateTime.now();
  final DateTime twelveHoursLater = now.add(Duration(hours: 12));
  DateTime? closestTime;

  scheduledTimes.forEach((day, times) {
    for (var time in times) {
      DateTime scheduledDateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
      if (scheduledDateTime.isBefore(twelveHoursLater) && scheduledDateTime.isAfter(now)) {
        if (closestTime == null || scheduledDateTime.isBefore(closestTime!)) {
          closestTime = scheduledDateTime;
        }
      }
    }
  });

  return closestTime;
}

double calculateFillRatio(DateTime? scheduledTime) {
  final DateTime now = DateTime.now();
  if (scheduledTime == null) {
    return 0.0; // Medication is not scheduled for today.
  }

  DateTime adjustedScheduledTime = DateTime(
      now.year, now.month, now.day, scheduledTime.hour, scheduledTime.minute);

  // If the scheduled time is before now or more than 12 hours ahead, it's considered not scheduled for the current period.
  if (adjustedScheduledTime.isBefore(now) ||
      adjustedScheduledTime.isAfter(now.add(Duration(hours: 12)))) {
    return 0.0;
  }

  final DateTime startTime = adjustedScheduledTime.subtract(Duration(hours: 12));
  final double totalDuration = Duration(hours: 12).inMinutes.toDouble();
  final double elapsed = now.difference(startTime).inMinutes.toDouble();

  return elapsed / totalDuration;
}


// General Map<String, dynamic> recursive equality checker.
bool areMapsEqual(Map<String, dynamic> map1, Map<String, dynamic> map2) {
  if (map1.length != map2.length) {
    return false;
  }

  for (String key in map1.keys) {
    if (!map2.containsKey(key)) {
      return false;
    }

    var value1 = map1[key];
    var value2 = map2[key];

    if (value1 is Map && value2 is Map) {
      if (!areMapsEqual(value1 as Map<String, dynamic>, value2 as Map<String, dynamic>)) {
        return false;
      }
    } else if (value1 is List && value2 is List) {
      if (!areListsEqual(value1, value2)) {
        return false;
      }
    } else if (value1 != value2) {
      return false;
    }
  }

  return true;
}

bool areListsEqual(List list1, List list2) {
  if (list1.length != list2.length) {
    return false;
  }

  for (int i = 0; i < list1.length; i++) {
    var value1 = list1[i];
    var value2 = list2[i];

    if (value1 is Map && value2 is Map) {
      if (!areMapsEqual(value1 as Map<String, dynamic>, value2 as Map<String, dynamic>)) {
        return false;
      }
    } else if (value1 is List && value2 is List) {
      if (!areListsEqual(value1, value2)) {
        return false;
      }
    } else if (value1 != value2) {
      return false;
    }
  }

  return true;
}

