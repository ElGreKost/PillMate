import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedicationProvider extends ChangeNotifier {
  String? _selectedPillName;

  String? get selectedPillName => _selectedPillName;

  String? _selectedPillType;

  String? get selectedPillType => _selectedPillType;

  IconData? _selectedPillIconData;

  IconData? get selectedPillIconData => _selectedPillIconData;

  List<int> _selectedDays = List.generate(10, (index) => 0);

  List<int> get selectedDays => _selectedDays;

  String? _betweenMeals = 'Anytime';

  String? get betweenMeals => _betweenMeals;

  List<DateTime?> _scheduledTimeList = [];

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
  void setScheduledTimeList(List<int> activeDays, TimeOfDay time) {
    DateTime findNextDayOfWeek(int targetWeekday) {
      DateTime now = DateTime.now();
      int currentWeekday = now.weekday;

      int daysToAdd;
      if (currentWeekday <= targetWeekday) { // this week
        daysToAdd = targetWeekday - currentWeekday;
      } else { // next week
        daysToAdd = (7 - currentWeekday) + targetWeekday;}

      return DateTime(now.year, now.month, now.day + daysToAdd);
    }

    for (int iDay = 1; iDay <= 7; iDay++) {
      if (_selectedDays.contains(iDay)) {
        _scheduledTimeList[iDay] = findNextDayOfWeek(iDay).add(Duration(hours:time.hour, minutes: time.minute));
      } else {
        _scheduledTimeList[iDay] = null;
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
        'exactTime': _scheduledTimeList.toString(),
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
