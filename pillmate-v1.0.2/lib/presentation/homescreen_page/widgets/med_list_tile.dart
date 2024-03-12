import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/services/medication_data_provider.dart';
import 'package:provider/provider.dart';

import '../../../backend/app_state.dart';
import '../../../services/medication.dart'; // Adjust the import paths as necessary.

class MedListTile extends StatefulWidget {
  final Medication medication;

  const MedListTile({Key? key, required this.medication}) : super(key: key);

  @override
  _MedListTileState createState() => _MedListTileState();
}

class _MedListTileState extends State<MedListTile> {
  bool _isLongPressed = false;

  double calculateFillRatio(DateTime scheduledTime) {
    final DateTime now = DateTime.now();
    final DateTime startTime = scheduledTime.subtract(Duration(hours: 12)); // 12 hours before the scheduled time

    if (now.isBefore(startTime)) {
      return 0.0; // Too early, no fill
    } else if (now.isAfter(scheduledTime)) {
      return 1.0; // Past the scheduled time, full fill
    } else {
      final double totalDuration = scheduledTime.difference(startTime).inMinutes.toDouble();
      final double elapsed = now.difference(startTime).inMinutes.toDouble();
      return elapsed / totalDuration; // Ratio of the fill based on the current time
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isLongPressed = !_isLongPressed;
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _isLongPressed ? _buildLongPressView() : _buildDefaultView(),
      ),
    );
  }

  Widget _buildDefaultView() {
    final double fillRatio = calculateFillRatio(widget.medication.scheduledTime);
    final Color fillColor = appTheme.cyan500; // Use a primary theme color for fill

    return Container(
      key: ValueKey('defaultView'),
      decoration: AppDecoration.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: fillRatio,
                child: Container(
                  decoration:
                      BoxDecoration(color: fillColor.withOpacity(0.5), borderRadius: BorderRadius.circular(30.h)),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: Icon(widget.medication.icon, size: 48.h, color: appTheme.cyan500),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('h:mm a').format(widget.medication.scheduledTime),
                          style: TextStyle(fontSize: 12.v, color: Colors.grey)),
                      Text(widget.medication.name, style: CustomTextStyles.headlineSmallBold),
                      SizedBox(height: 4.v),
                      Text("1 ${widget.medication.kind} \t ${widget.medication.betweenMeals}",
                          style: theme.textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLongPressView() {
    return Container(
      key: ValueKey('longPressView'), // Unique key for AnimatedSwitcher
      padding: EdgeInsets.fromLTRB(12.h, 6.v, 13.h, 7.v),
      decoration: AppDecoration.white,
      child: Column(
        children: [
          // Pill name for verification
          Padding(
            padding: EdgeInsets.only(bottom: 8.v), // Add some space below the pill name
            child: Text(widget.medication.name, style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold)),
          ),
          // Scrollable row for actions
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center the icons in the row
              children: [
                _buildIconButton(Icons.check_circle, "Take", Colors.green, () {
                  Provider.of<AppState>(context, listen: false).deleteMedication(widget.medication);
                }),
                SizedBox(width: 16.h),
                _buildIconButton(Icons.edit, "Edit", Colors.blue, () {
                  // Handle "Edit" action
                }),
                SizedBox(width: 16.h),
                _buildIconButton(Icons.info, "Info", Colors.amber, () {
                  // Handle "Info" action
                }),
                SizedBox(width: 16.h),
                _buildIconButton(Icons.delete, "Delete", Colors.red, () {
                  print('clicked delete');
                  Provider.of<AppState>(context, listen: false).deleteMedication(widget.medication);
                }),
              ]),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String tooltip, Color color, VoidCallback onPressed) {
    return IconButton(icon: Icon(icon, size: 40.h), color: color, tooltip: tooltip, onPressed: onPressed);
  }

  Widget _buildOptionButton(String title, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Add some padding around the buttons
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners for buttons
          ),
          textStyle: TextStyle(fontSize: 16.h), // Larger text size for better readability
          padding: EdgeInsets.symmetric(vertical: 12.v, horizontal: 24.h), // Custom padding
        ),
        child: Text(title),
      ),
    );
  }
}
