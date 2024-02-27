import '../../../core/app_export.dart';

/// This class is used in the [eventlist_item_widget] screen.
class EventlistItemModel {
  EventlistItemModel({
    this.time,
    this.am,
    this.acetaminophen,
    this.pillCounter,
    this.beforeFood,
    this.id,
  }) {
    time = time ?? "8:00 AM";
    am = am ?? ImageConstant.imgThumbsUp;
    acetaminophen = acetaminophen ?? "Acetaminophen";
    pillCounter = pillCounter ?? "1 Pill";
    beforeFood = beforeFood ?? "Before Food";
    id = id ?? "";
  }

  String? time;

  String? am;

  String? acetaminophen;

  String? pillCounter;

  String? beforeFood;

  String? id;
}
