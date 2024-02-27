import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/chooseday_model.dart';
import '../models/chooseday_item_model.dart';

/// A provider class for the ChoosedayScreen.
///
/// This provider manages the state of the ChoosedayScreen, including the
/// current choosedayModelObj

// ignore_for_file: must_be_immutable
class ChoosedayProvider extends ChangeNotifier {
  ChoosedayModel choosedayModelObj = ChoosedayModel();

  @override
  void dispose() {
    super.dispose();
  }
}
