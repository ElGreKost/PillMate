import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/settime_model.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

/// A provider class for the SettimeScreen.
///
/// This provider manages the state of the SettimeScreen, including the
/// current settimeModelObj

// ignore_for_file: must_be_immutable
class SettimeProvider extends ChangeNotifier {
  SettimeModel settimeModelObj = SettimeModel();

  List<DateTime?>? selectedDatesFromCalendar1;

  @override
  void dispose() {
    super.dispose();
  }
}
