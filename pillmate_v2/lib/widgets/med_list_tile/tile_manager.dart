// tile_manager.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../services/medication.dart';
import 'tile_utils.dart';

class TileManager extends ChangeNotifier {
  bool _isLongPressed = false;
  bool _isEditPressed = false;
  bool _isInfoPressed = false;

  bool get isLongPressed => _isLongPressed;
  bool get isEditPressed => _isEditPressed;
  bool get isInfoPressed => _isInfoPressed;

  void toggleLongPress() {
    _isLongPressed = !_isLongPressed;
    notifyListeners();
  }

  void toggleEditPress() {
    _isEditPressed = !_isEditPressed;
    notifyListeners();
  }

  void toggleInfoPress() {
    _isInfoPressed = !_isInfoPressed;
    notifyListeners();
  }

  Future<void> deleteMedicationFromBox(Medication medication) async {
    Map<dynamic, dynamic> medicationData = medication.toMap();
    try {
      final Box medicationsBox = await Hive.openBox('medications');
      dynamic medicationKey;

      for (var key in medicationsBox.keys) {
        final storedData = medicationsBox.get(key);
        if (storedData != null && storedData is Map<dynamic, dynamic>) {
          final Map<String, dynamic> storedMap = Map<String, dynamic>.from(storedData);
          final Map<String, dynamic> medicationDataMap = medicationData as Map<String, dynamic>;

          if (areMapsEqual(storedMap, medicationDataMap)) {
            medicationKey = key;
            break;
          }
        }
      }

      if (medicationKey != null) {
        print('in deletion');
        await medicationsBox.delete(medicationKey);
      }
    } catch (e) {
      print('Error deleting medication from Hive: $e');
    }
  }

}
