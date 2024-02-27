import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/iphone_11_pro_max_six_model.dart';
import '../models/view1_item_model.dart';

/// A provider class for the Iphone11ProMaxSixScreen.
///
/// This provider manages the state of the Iphone11ProMaxSixScreen, including the
/// current iphone11ProMaxSixModelObj

// ignore_for_file: must_be_immutable
class Iphone11ProMaxSixProvider extends ChangeNotifier {
  Iphone11ProMaxSixModel iphone11ProMaxSixModelObj = Iphone11ProMaxSixModel();

  @override
  void dispose() {
    super.dispose();
  }
}
