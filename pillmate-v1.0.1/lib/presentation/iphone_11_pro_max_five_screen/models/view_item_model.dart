import '../../../core/app_export.dart';

/// This class is used in the [view_item_widget] screen.
class ViewItemModel {
  ViewItemModel({
    this.pill,
    this.pill1,
    this.id,
  }) {
    pill = pill ?? "Pill";
    pill1 = pill1 ?? "Pill";
    id = id ?? "";
  }

  String? pill;

  String? pill1;

  String? id;
}
