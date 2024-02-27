import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/iphone_11_pro_max_thirteen_model.dart';

/// A provider class for the Iphone11ProMaxThirteenScreen.
///
/// This provider manages the state of the Iphone11ProMaxThirteenScreen, including the
/// current iphone11ProMaxThirteenModelObj

// ignore_for_file: must_be_immutable
class Iphone11ProMaxThirteenProvider extends ChangeNotifier {
  Iphone11ProMaxThirteenModel iphone11ProMaxThirteenModelObj =
      Iphone11ProMaxThirteenModel();

  String radioGroup = "";

  @override
  void dispose() {
    super.dispose();
  }

  void changeRadioButton1(String value) {
    radioGroup = value;
    notifyListeners();
  }
}
