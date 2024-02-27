import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/iphone_11_pro_max_sixteen_model.dart';

/// A provider class for the Iphone11ProMaxSixteenScreen.
///
/// This provider manages the state of the Iphone11ProMaxSixteenScreen, including the
/// current iphone11ProMaxSixteenModelObj

// ignore_for_file: must_be_immutable
class Iphone11ProMaxSixteenProvider extends ChangeNotifier {
  Iphone11ProMaxSixteenModel iphone11ProMaxSixteenModelObj =
      Iphone11ProMaxSixteenModel();

  String radioGroup = "";

  String radioGroup1 = "";

  String radioGroup2 = "";

  String radioGroup3 = "";

  @override
  void dispose() {
    super.dispose();
  }

  void changeRadioButton1(String value) {
    radioGroup = value;
    notifyListeners();
  }

  void changeRadioButton2(String value) {
    radioGroup1 = value;
    notifyListeners();
  }

  void changeRadioButton3(String value) {
    radioGroup2 = value;
    notifyListeners();
  }

  void changeRadioButton4(String value) {
    radioGroup3 = value;
    notifyListeners();
  }
}
