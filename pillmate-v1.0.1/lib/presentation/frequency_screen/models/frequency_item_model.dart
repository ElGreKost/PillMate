import '../../../core/app_export.dart';

/// This class is used in the [frequency_item_widget] screen.
class FrequencyItemModel {
  FrequencyItemModel({
    this.daily,
    this.daily1,
    this.id,
  }) {
    daily = daily ?? "Daily";
    daily1 = daily1 ?? "Daily";
    id = id ?? "";
  }

  String? daily;

  String? daily1;

  String? id;
}
