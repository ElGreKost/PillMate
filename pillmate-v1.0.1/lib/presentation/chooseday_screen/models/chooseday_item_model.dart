import '../../../core/app_export.dart';

/// This class is used in the [chooseday_item_widget] screen.
class ChoosedayItemModel {
  ChoosedayItemModel({
    this.sunday,
    this.sunday1,
    this.id,
  }) {
    sunday = sunday ?? "Sunday";
    sunday1 = sunday1 ?? "Sunday";
    id = id ?? "";
  }

  String? sunday;

  String? sunday1;

  String? id;
}
