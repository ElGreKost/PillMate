import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/iphone_11_pro_max_twentysix_model.dart';
import '../models/time_item_model.dart';

/// A provider class for the Iphone11ProMaxTwentysixPage.
///
/// This provider manages the state of the Iphone11ProMaxTwentysixPage, including the
/// current iphone11ProMaxTwentysixModelObj

// ignore_for_file: must_be_immutable
class Iphone11ProMaxTwentysixProvider extends ChangeNotifier {
  Iphone11ProMaxTwentysixModel iphone11ProMaxTwentysixModelObj =
      Iphone11ProMaxTwentysixModel();

  @override
  void dispose() {
    super.dispose();
  }
}
