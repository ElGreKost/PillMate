import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/iphone_11_pro_max_fourteen_model.dart';

/// A provider class for the Iphone11ProMaxFourteenScreen.
///
/// This provider manages the state of the Iphone11ProMaxFourteenScreen, including the
/// current iphone11ProMaxFourteenModelObj

// ignore_for_file: must_be_immutable
class Iphone11ProMaxFourteenProvider extends ChangeNotifier {
  Iphone11ProMaxFourteenModel iphone11ProMaxFourteenModelObj =
      Iphone11ProMaxFourteenModel();

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
