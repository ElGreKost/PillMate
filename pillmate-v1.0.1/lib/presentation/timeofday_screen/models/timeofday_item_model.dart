import '../../../core/app_export.dart';

/// This class is used in the [timeofday_item_widget] screen.
class TimeofdayItemModel {
  TimeofdayItemModel({
    this.morning,
    this.morning1,
    this.beforeFood,
    this.beforeFood1,
    this.id,
  }) {
    morning = morning ?? "Morning";
    morning1 = morning1 ?? "Morning";
    beforeFood = beforeFood ?? "Before Food";
    beforeFood1 = beforeFood1 ?? "Before Food";
    id = id ?? "";
  }

  String? morning;

  String? morning1;

  String? beforeFood;

  String? beforeFood1;

  String? id;
}
