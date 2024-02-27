import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/timeofday_model.dart';
import '../models/timeofday_item_model.dart';

/// A provider class for the TimeofdayScreen.
///
/// This provider manages the state of the TimeofdayScreen, including the
/// current timeofdayModelObj

// ignore_for_file: must_be_immutable
class TimeofdayProvider extends ChangeNotifier {
  TimeofdayModel timeofdayModelObj = TimeofdayModel();

  @override
  void dispose() {
    super.dispose();
  }
}
