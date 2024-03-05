import 'package:flutter/material.dart';

class ButtonsPanel extends StatefulWidget {
  final int currentIndex;
  final List<Widget> children;
  final Color backgroundColor;
  final Size? size;
  final EdgeInsets? padding;
  final Axis direction;
  final BoxDecoration? decoration;
  final BorderRadiusGeometry? borderRadius;
  final Color? foregroundColor, selectedItemBackgroundColor;
  final TextStyle? selectedTextStyle, unselectedTextStyle;
  final IconThemeData? selectedIconThemeData, unselectedIconThemeData;
  final Function(int) onTap;

  const ButtonsPanel({
    required this.onTap,
    required this.currentIndex,
    required this.children,
    required this.backgroundColor,
    this.size,
    this.padding = const EdgeInsets.all(0),
    this.decoration,
    this.foregroundColor,
    this.selectedItemBackgroundColor,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.selectedIconThemeData,
    this.unselectedIconThemeData,
    this.direction = Axis.horizontal,
    this.borderRadius,
  }) : assert(0 <= currentIndex && currentIndex < children.length);

  @override
  State<ButtonsPanel> createState() => _ButtonsPanelState();
}

class _ButtonsPanelState extends State<ButtonsPanel> {
  @override
  Widget build(BuildContext context) {
    // Ensure decoration is applied on Container with defined color.
    BoxDecoration decoration = widget.decoration ??
        BoxDecoration(
          color: widget.backgroundColor, // Move the background color to the decoration
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
        );

    return Container(
      width: widget.direction == Axis.horizontal ? widget.size?.width : null,
      height: widget.direction == Axis.vertical ? widget.size?.height : null,
      padding: widget.padding,
      decoration: decoration, // Use the updated decoration
      child: widget.direction == Axis.vertical
          ? Column(mainAxisSize: MainAxisSize.min, children: _buttons())
          : Row(mainAxisSize: MainAxisSize.min, children: _buttons()),
    );
  }

  List<Widget> _buttons() {
    return List<Widget>.generate(widget.children.length, (i) {
      bool isActive = widget.currentIndex == i;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            widget.onTap(i);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            // Apply a border radius to each item if needed
            decoration: BoxDecoration(
              color: isActive
                  ? widget.selectedItemBackgroundColor ?? widget.backgroundColor
                  : widget.backgroundColor,
              borderRadius: widget.borderRadius,
            ),
            child: Center(
              child: DefaultTextStyle(
                style: isActive
                    ? widget.selectedTextStyle ?? TextStyle(color: widget.foregroundColor)
                    : widget.unselectedTextStyle ?? TextStyle(color: widget.foregroundColor),
                child: IconTheme(
                  data: isActive
                      ? widget.selectedIconThemeData ?? IconThemeData(color: widget.foregroundColor)
                      : widget.unselectedIconThemeData ?? IconThemeData(color: widget.foregroundColor),
                  child: widget.children[i],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

