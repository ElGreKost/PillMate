import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/iphone_11_pro_max_five_model.dart';
import '../models/view_item_model.dart';

/// A provider class for the Iphone11ProMaxFiveScreen.
///
/// This provider manages the state of the Iphone11ProMaxFiveScreen, including the
/// current iphone11ProMaxFiveModelObj

// ignore_for_file: must_be_immutable
class Iphone11ProMaxFiveProvider extends ChangeNotifier {
  Iphone11ProMaxFiveModel iphone11ProMaxFiveModelObj =
      Iphone11ProMaxFiveModel();

  @override
  void dispose() {
    super.dispose();
  }
}
