import 'package:flutter/services.dart' show rootBundle;

class MedicationManager {
  static final MedicationManager _instance = MedicationManager._internal();
  List<String>? _medicationNames; // Nullable to indicate uninitialized state

  factory MedicationManager() {
    return _instance;
  }

  MedicationManager._internal();

  Future<void> _initialize() async {
    String fileContent = await rootBundle.loadString('assets/medication_names.txt');
    _medicationNames = fileContent.split('\n').map((String name) => name.trim()).toList();
    _medicationNames!.removeWhere((String name) => name.isEmpty);
  }

  Future<List<String>> getMedicationNames() async {
    // Lazy initialization: compute the list if it's null
    if (_medicationNames == null) {
      await _initialize();
    }
    return _medicationNames!;
  }
}
