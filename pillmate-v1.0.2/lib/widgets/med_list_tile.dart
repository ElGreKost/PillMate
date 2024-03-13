import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:provider/provider.dart';

import '../backend/app_state.dart';
import '../services/medication.dart'; // Adjust the import paths as necessary.

class MedListTile extends StatefulWidget {
  final Medication medication;

  const MedListTile({Key? key, required this.medication}) : super(key: key);

  @override
  _MedListTileState createState() => _MedListTileState();
}

class _MedListTileState extends State<MedListTile> {
  bool _isLongPressed = false;
  bool _isEditPressed = false;

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
          _isLongPressed = true; // Enable the initial long press state
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _isEditPressed
            ? _buildExpandedView()
            : _isLongPressed
                ? _buildLongPressView()
                : _buildDefaultView(),
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
                _buildIconButton(Icons.edit, "Edit", Colors.blue, () => setState(() => _isEditPressed = true)),
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

  Widget _buildExpandedView() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      key: ValueKey('expandedView'),
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.white,
      height: _isLongPressed ? 300.h : 100.h,
      // Adjust height based on the state
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Existing row for medication details
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
            SizedBox(height: 16.h),
            // TextField for notes
            TextField(
              maxLines: 3,
              decoration: InputDecoration(hintText: "Write notes about this treatment..."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle save logic here
                    setState(() {
                      _isEditPressed = false;
                      _isLongPressed = false;
                    });
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    // Optionally handle additional logic here
                    setState(() {
                      _isEditPressed = false;
                      _isLongPressed = false;
                    });
                  },
                  child: Text('Cancel'),
                  // color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String tooltip, Color color, VoidCallback onPressed) {
    return IconButton(icon: Icon(icon, size: 40.h), color: color, tooltip: tooltip, onPressed: onPressed);
  }
}
