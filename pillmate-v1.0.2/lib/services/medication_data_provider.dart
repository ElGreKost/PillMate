import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedicationProvider extends ChangeNotifier {
  String? _selectedPillName;

  String? get selectedPillName => _selectedPillName;

  String? _selectedPillType;

  String? get selectedPillType => _selectedPillType;

  IconData? _selectedPillIconData;

  IconData? get selectedPillIconData => _selectedPillIconData;

  List<int> _selectedDays = List.generate(7, (index) => 0);

  List<int> get selectedDays => _selectedDays;

  String? _betweenMeals = 'Anytime';

  String? get betweenMeals => _betweenMeals;

  List<DateTime?> _scheduledTimeList = List.generate(7, (index) => null);

  List<DateTime?> get scheduledTimeList => _scheduledTimeList;

  // Method to set selected pill name
  void setSelectedPillName(String pillName) {
    _selectedPillName = pillName;
    notifyListeners();
  }

  void setSelectedPillType(String pillType) {
    _selectedPillType = pillType;
    notifyListeners();
  }

  void setSelectedPillIconData(IconData value) {
    _selectedPillIconData = value;
    notifyListeners();
  }

  // Method to set selected days
  void setSelectedDays(List<int> days) {
    _selectedDays = days;
    notifyListeners();
  }

  // Method to set between meals
  void setBetweenMeals(String value) {
    _betweenMeals = value;
    notifyListeners();
  }

  // Method to set exact time
  void setScheduledTimeList(List<DateTime?> times) {
    DateTime findNextDayOfWeek(int targetWeekday) {
      DateTime now = DateTime.now();
      int currentWeekday = now.weekday;

      int daysToAdd;
      if (currentWeekday <= targetWeekday) { // this week
        daysToAdd = targetWeekday - currentWeekday;
      } else { // next week
        daysToAdd = (7 - currentWeekday) + targetWeekday;
      }

      return DateTime(now.year, now.month, now.day + daysToAdd);
    }

    for (int iWeekday = 1; iWeekday <= 7; iWeekday++) {
      if (_selectedDays.contains(iWeekday)) {
        DateTime? time = times[iWeekday - 1];
        if (time != null) {
          DateTime nextDay = findNextDayOfWeek(iWeekday);
          DateTime scheduledTime = DateTime(
              nextDay.year, nextDay.month, nextDay.day, time.hour, time.minute);
          _scheduledTimeList[iWeekday - 1] = scheduledTime;
        }
      } else {
        _scheduledTimeList[iWeekday - 1] = null;
      }
    }
    notifyListeners();
  }



  Future<void> addMedication() async {
    try {
      final Box medicationsBox = await Hive.openBox('medications');

      // Print out the data before adding it to Hive
      print('Adding medication to Hive:');
      print('Name: $_selectedPillName');
      print('Type: $_selectedPillType');
      print('Days: $_selectedDays');
      print('Between Meals: $_betweenMeals');
      print('Exact Time: $_scheduledTimeList');

      // Create data to be added to Hive
      Map<String, dynamic> data = {
        'name': _selectedPillName,
        'type': _selectedPillType,
        'days': _selectedDays,
        'betweenMeals': _betweenMeals,
        'scheduledTimeList': _scheduledTimeList.map((dateTime) => dateTime?.millisecondsSinceEpoch).toList(),
        // Storing TimeOfDay as String
      };

      // Add medication data to Hive
      await medicationsBox.add(data);

      print('Medication added successfully!');

      // Print the contents of the box
      print('Contents of medications box:');
      for (var i = 0; i < medicationsBox.length; i++) {
        print(medicationsBox.getAt(i));
      }
    } catch (e) {
      print('Error adding medication to Hive: $e');
    }
  }
}
