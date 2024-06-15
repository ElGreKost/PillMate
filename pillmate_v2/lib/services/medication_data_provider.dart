import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedicationProvider extends ChangeNotifier {
  String? _selectedPillName;

  String? get selectedPillName => _selectedPillName;

  String? _selectedPillType;

  String? get selectedPillType => _selectedPillType;

  IconData? _selectedPillIconData;

  IconData? get selectedPillIconData => _selectedPillIconData;

  List<String> _selectedDays = [];

  List<String> get selectedDays => _selectedDays;

  String? _betweenMeals = 'Anytime';

  String? get betweenMeals => _betweenMeals;

  Map<String, List<TimeOfDay>> _scheduledTimes = {};

  Map<String, List<TimeOfDay>> get scheduledTimes => _scheduledTimes;

  DateTime? _repeatUntil;

  DateTime? get repeatUntil => _repeatUntil;

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

  void setSelectedDays(List<String> days) {
    _selectedDays = days;
    notifyListeners();
  }

  void setBetweenMeals(String value) {
    _betweenMeals = value;
    notifyListeners();
  }

  void setScheduledTimes(String day, List<TimeOfDay> times) {
    _scheduledTimes[day] = times;
    notifyListeners();
  }

  void addScheduledTime(String day, TimeOfDay time) {
    if (_scheduledTimes[day] == null) {
      _scheduledTimes[day] = [];
    }
    _scheduledTimes[day]!.add(time);
    notifyListeners();
  }

  void removeScheduledTime(String day, TimeOfDay time) {
    _scheduledTimes[day]?.remove(time);
    if (_scheduledTimes[day]?.isEmpty ?? true) {
      _scheduledTimes.remove(day);
    }
    notifyListeners();
  }

  void setRepeatUntil(DateTime? date) {
    _repeatUntil = date;
    notifyListeners();
  }

  Future<void> addMedication() async {
    try {
      final Box medicationsBox = await Hive.openBox('medications');

      print('Adding medication to Hive:');
      print('Name: $_selectedPillName');
      print('Type: _selectedPillType');
      print('Days: $_selectedDays');
      print('Between Meals: $_betweenMeals');
      print('Scheduled Times: $_scheduledTimes');
      print('Repeat Until: $_repeatUntil');

      Map<String, List<String>> scheduledTimesAsString = _scheduledTimes.map(
              (day, times) => MapEntry(
              day,
              times
                  .map((time) =>
              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}')
                  .toList()));

      Map<String, dynamic> data = {
        'name': _selectedPillName,
        'type': _selectedPillType,
        'betweenMeals': _betweenMeals,
        'scheduledTimes': scheduledTimesAsString,
        'repeatUntil': _repeatUntil?.millisecondsSinceEpoch,
      };

      await medicationsBox.add(data);

      print('Medication added successfully!');
      print('Contents of medications box:');
      for (var i = 0; i < medicationsBox.length; i++) {
        print(medicationsBox.getAt(i));
      }
    } catch (e) {
      print('Error adding medication to Hive: $e');
    }
  }
}
