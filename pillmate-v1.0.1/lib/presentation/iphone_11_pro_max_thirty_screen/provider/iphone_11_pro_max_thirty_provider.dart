import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/iphone_11_pro_max_thirty_model.dart';

/// A provider class for the Iphone11ProMaxThirtyScreen.
///
/// This provider manages the state of the Iphone11ProMaxThirtyScreen, including the
/// current iphone11ProMaxThirtyModelObj

// ignore_for_file: must_be_immutable
class Iphone11ProMaxThirtyProvider extends ChangeNotifier {
  TextEditingController rinController = TextEditingController();

  Iphone11ProMaxThirtyModel iphone11ProMaxThirtyModelObj =
      Iphone11ProMaxThirtyModel();

  @override
  void dispose() {
    super.dispose();
    rinController.dispose();
  }
}
