import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/frequency_model.dart';
import '../models/frequency_item_model.dart';

/// A provider class for the FrequencyScreen.
///
/// This provider manages the state of the FrequencyScreen, including the
/// current frequencyModelObj

// ignore_for_file: must_be_immutable
class FrequencyProvider extends ChangeNotifier {
  FrequencyModel frequencyModelObj = FrequencyModel();

  @override
  void dispose() {
    super.dispose();
  }
}
