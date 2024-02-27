import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/homescreen_container_model.dart';

/// A provider class for the HomescreenContainerScreen.
///
/// This provider manages the state of the HomescreenContainerScreen, including the
/// current homescreenContainerModelObj

// ignore_for_file: must_be_immutable
class HomescreenContainerProvider extends ChangeNotifier {
  HomescreenContainerModel homescreenContainerModelObj =
      HomescreenContainerModel();

  @override
  void dispose() {
    super.dispose();
  }
}
