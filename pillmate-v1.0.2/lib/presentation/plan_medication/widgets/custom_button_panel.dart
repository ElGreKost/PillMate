import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

class CustomButtonPanel extends StatefulWidget {
  final List<String> labels;
  final int selectedIndex;
  final Function(int) onSelected;

  CustomButtonPanel({
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  _CustomButtonPanelState createState() => _CustomButtonPanelState();
}

class _CustomButtonPanelState extends State<CustomButtonPanel> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(widget.labels.length, (int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ChoiceChip(
            label: Text(widget.labels[index]),
            selected: widget.selectedIndex == index,
            onSelected: (_) => widget.onSelected(index),
            selectedColor: appTheme.cyan900,
            backgroundColor: appTheme.grey500,
            labelStyle: TextStyle(
              color: widget.selectedIndex == index ? appTheme.teal100 : appTheme.grey100,
                fontWeight: FontWeight.bold
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        );
      }),
    );
  }
}
