import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/addpill_model.dart';

/// A provider class for the AddpillScreen.
///
/// This provider manages the state of the AddpillScreen, including the
/// current addpillModelObj

// ignore_for_file: must_be_immutable
class AddpillProvider extends ChangeNotifier {
  AddpillModel addpillModelObj = AddpillModel();

  @override
  void dispose() {
    super.dispose();
  }
}
