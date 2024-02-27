import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/addmedication_model.dart';

/// A provider class for the AddmedicationScreen.
///
/// This provider manages the state of the AddmedicationScreen, including the
/// current addmedicationModelObj

// ignore_for_file: must_be_immutable
class AddmedicationProvider extends ChangeNotifier {
  TextEditingController editTextController = TextEditingController();

  AddmedicationModel addmedicationModelObj = AddmedicationModel();

  @override
  void dispose() {
    super.dispose();
    editTextController.dispose();
  }
}
