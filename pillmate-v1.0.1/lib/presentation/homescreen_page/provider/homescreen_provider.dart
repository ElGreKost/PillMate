import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/homescreen_model.dart';
import '../models/eventlist_item_model.dart';

/// A provider class for the HomescreenPage.
///
/// This provider manages the state of the HomescreenPage, including the
/// current homescreenModelObj

// ignore_for_file: must_be_immutable
class HomescreenProvider extends ChangeNotifier {
  HomescreenModel homescreenModelObj = HomescreenModel();

  @override
  void dispose() {
    super.dispose();
  }
}
