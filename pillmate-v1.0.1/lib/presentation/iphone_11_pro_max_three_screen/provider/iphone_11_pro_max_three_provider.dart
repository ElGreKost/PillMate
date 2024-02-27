import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/iphone_11_pro_max_three_model.dart';

/// A provider class for the Iphone11ProMaxThreeScreen.
///
/// This provider manages the state of the Iphone11ProMaxThreeScreen, including the
/// current iphone11ProMaxThreeModelObj

// ignore_for_file: must_be_immutable
class Iphone11ProMaxThreeProvider extends ChangeNotifier {
  Iphone11ProMaxThreeModel iphone11ProMaxThreeModelObj =
      Iphone11ProMaxThreeModel();

  @override
  void dispose() {
    super.dispose();
  }
}
