import '../../../core/app_export.dart';

/// This class is used in the [time_item_widget] screen.
class TimeItemModel {
  TimeItemModel({
    this.time,
    this.acetaminophen,
    this.pillCounter,
    this.beforeFood,
    this.id,
  }) {
    time = time ?? "8:00 AM";
    acetaminophen = acetaminophen ?? "Acetaminophen";
    pillCounter = pillCounter ?? "1 Pill";
    beforeFood = beforeFood ?? "Before Food";
    id = id ?? "";
  }

  String? time;

  String? acetaminophen;

  String? pillCounter;

  String? beforeFood;

  String? id;
}
