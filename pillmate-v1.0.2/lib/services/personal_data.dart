import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


// Step 2: Define a Provider class to manage the state
class UserDataProvider extends ChangeNotifier {
  String? _name;

  String? get name => _name;

  String? _lovedName;

  String? get lovedName => _lovedName;

  String? _phoneNumber;

  String? get phoneNumber => _phoneNumber;

  // Method to update firstName
  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void updateLovedName(String value) {
    _lovedName = value;
    notifyListeners();
  }


  // Method to update phoneNumber
  void updatePhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  Future<void> addData() async {
    try {
      final Box dataBox = await Hive.openBox('userdata');

      // Check if data exists in the box
      if (dataBox.isNotEmpty) {
        // Update existing data
        dataBox.put(0, {
          'name': _name,
          'lovedName': _lovedName,
          'phoneNumber': _phoneNumber,
        });
        print('Data updated successfully');
      } else {
        // Add new data
        Map<String, dynamic> data = {
          'name': _name,
          'lovedName': _lovedName,
          'phoneNumber': _phoneNumber,
        };
        await dataBox.add(data);
        print('Data added successfully');
      }
    } catch (e) {
      print('Error adding/updating data to Hive: $e');
    }
  }


}