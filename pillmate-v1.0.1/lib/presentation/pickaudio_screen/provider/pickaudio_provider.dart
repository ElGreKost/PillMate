import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/pickaudio_model.dart';

/// A provider class for the PickaudioScreen.
///
/// This provider manages the state of the PickaudioScreen, including the
/// current pickaudioModelObj

// ignore_for_file: must_be_immutable
class PickaudioProvider extends ChangeNotifier {
  PickaudioModel pickaudioModelObj = PickaudioModel();

  @override
  void dispose() {
    super.dispose();
  }
}
