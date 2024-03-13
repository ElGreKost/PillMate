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

  String? _betweenMeals;

  String? get betweenMeals => _betweenMeals;

  DateTime? _exactTime;

  DateTime? get exactTime => _exactTime;

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
  void setSelectedDays(List<String> days) {
    _selectedDays = days;
    notifyListeners();
  }

  // Method to set between meals
  void setBetweenMeals(String value) {
    _betweenMeals = value;
    notifyListeners();
  }

  // Method to set exact time
  void setExactTime(TimeOfDay time) {
    final now = DateTime.now();
    final timeOfDay2DateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    _exactTime = timeOfDay2DateTime;
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
      print('Exact Time: $_exactTime');

      // Create data to be added to Hive
      Map<String, dynamic> data = {
        'name': _selectedPillName,
        'type': _selectedPillType,
        'days': _selectedDays,
        'betweenMeals': _betweenMeals,
        'exactTime': _exactTime?.toString(), // Storing TimeOfDay as String
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
