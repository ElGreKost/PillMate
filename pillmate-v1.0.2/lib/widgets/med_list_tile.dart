import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import '../backend/app_state.dart';
import '../services/medication.dart'; // Adjust the import paths as necessary.
import 'package:flutter/foundation.dart';

bool areMapsEqual(Map<String, dynamic> map1, Map<String, dynamic> map2) {
// Compare the values of each key in the maps
  for (var key in map1.keys) {
    // Check if the values are lists and compare them using listEquals
    if (map1[key] is List && map2[key] is List) {
      if (!listEquals(map1[key], map2[key])) {
        return false;
      }
    } else {
      // For non-list values, compare directly
      if (map1[key] != map2[key]) {
        return false;
      }
    }
  }

// If all values are equal, return true
  return true;
}

class MedListTile extends StatefulWidget {
  final Medication medication;

  const MedListTile({Key? key, required this.medication}) : super(key: key);

  @override
  _MedListTileState createState() => _MedListTileState();
}

class _MedListTileState extends State<MedListTile> {
  bool _isLongPressed = false;
  bool _isEditPressed = false;
  bool _isInfoPressed = false;

  Future<void> deleteMedicationFromBox(
      Map<dynamic, dynamic> medicationData) async {
    try {
      final Box medicationsBox = await Hive.openBox('medications');

      dynamic medicationKey;

      for (var key in medicationsBox.keys) {
        final storedData = medicationsBox.get(key);
        if (storedData != null && storedData is Map<dynamic, dynamic>) {
          print('$storedData');
          final Map<String, dynamic> storedMap =
              Map<String, dynamic>.from(storedData);
          print('$storedMap');
          final Map<String, dynamic> medicationDataMap =
              medicationData as Map<String, dynamic>;
          print('$medicationDataMap');
          if (areMapsEqual(storedMap, medicationDataMap)) {
            print('found');
            medicationKey = key;
            break; // Break the loop once the key is found
          }
        }
      }

      if (medicationKey != null) {
        // Delete the medication from the box
        print('medication key is: $medicationKey');
        await medicationsBox.delete(medicationKey);

        print('Medication deleted successfully!');
      } else {
        print('Medication not found in the box.');
      }
    } catch (e) {
      print('Error deleting medication from Hive: $e');
    }
  }

  double? calculateFillRatio(DateTime? scheduledTime) {
    final DateTime now = DateTime.now();
    if (scheduledTime == null) {
      return null; // Medication is not scheduled for today.
    }

    DateTime adjustedScheduledTime = DateTime(now.year, now.month, now.day, scheduledTime.hour, scheduledTime.minute);

    // If the scheduled time is before now or more than 12 hours ahead, it's considered not scheduled for the current period.
    if (adjustedScheduledTime.isBefore(now) || adjustedScheduledTime.isAfter(now.add(Duration(hours: 12)))) {
      return null;
    }

    final DateTime startTime = adjustedScheduledTime.subtract(Duration(hours: 12));
    final double totalDuration = adjustedScheduledTime.difference(startTime).inMinutes.toDouble();
    final double elapsed = now.difference(startTime).inMinutes.toDouble();

    return elapsed / totalDuration;
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isLongPressed = true;
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _isInfoPressed
            ? _buildInfoView()
            : _isEditPressed
                ? _buildExpandedView()
                : _isLongPressed
                    ? _buildLongPressView()
                    : _buildViewBasedOnSchedule(),
      ),
    );
  }

  Widget _buildViewBasedOnSchedule() {
    DateTime? todayScheduledTime = widget.medication.scheduledTimeList[DateTime.now().weekday - 1];

    // Use the modified calculateFillRatio to also check for scheduling within 12 hours
    double? fillRatio = calculateFillRatio(todayScheduledTime);

    if (fillRatio == null) {
      // Display "Not Scheduled for Current Period" view
      return _buildNotScheduledTodayView(); // This can be renamed to reflect "not in the next 12 hours" if you like
    } else {
      // Proceed with the normal "Default View" using the fill ratio
      return _buildDefaultView(fillRatio);
    }
  }


  // Widget _buildDefaultOrNotScheduledView() {
  //   DateTime? todayScheduledTime = widget.medication.scheduledTimeList[DateTime.now().weekday - 1]; // Weekday is 1-based
  //
  //   if (todayScheduledTime == null) {
  //     // Display "Not Scheduled Today" view
  //     return _buildNotScheduledTodayView();
  //   } else {
  //     // Proceed with the normal "Default View" using todayScheduledTime
  //     final double fillRatio = calculateFillRatio(todayScheduledTime);
  //     final Color fillColor = appTheme.cyan500;
  //
  //     return Container(
  //       key: ValueKey('defaultView'),
  //       decoration: AppDecoration.white,
  //       child: Stack(
  //         children: [
  //           Positioned.fill(
  //             child: Align(
  //               alignment: Alignment.centerLeft,
  //               child: FractionallySizedBox(
  //                 widthFactor: fillRatio,
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       color: fillColor.withOpacity(0.5),
  //                       borderRadius: BorderRadius.circular(30.h)),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 12.h),
  //                 child: Icon(widget.medication.icon,
  //                     size: 48.h, color: appTheme.cyan500),
  //               ),
  //               Expanded(
  //                 child: Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 6.v),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         // DateFormat('HH:mm').format(widget.medication
  //                         //     .scheduledTimeList[DateTime.now().weekday]!), todo fix it
  //                           DateFormat('HH:mm').format(DateTime.now()),
  //                           style: TextStyle(
  //                               fontSize: 12.v, color: appTheme.grey100)),
  //                       Text(widget.medication.name,
  //                           style: CustomTextStyles.headlineSmallBold),
  //                       SizedBox(height: 4.v),
  //                       Text(
  //                           "1 ${widget.medication.type} \t ${widget.medication.betweenMeals}",
  //                           style: theme.textTheme.titleMedium),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  Widget _buildNotScheduledTodayView() {
    return Container(
      key: ValueKey('notScheduledTodayView'),
      decoration: AppDecoration.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(widget.medication.icon, size: 48, color: Colors.grey), // Example icon
          Text(widget.medication.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("Not scheduled for today", style: TextStyle(fontSize: 16, color: Colors.grey)),
          // You can add more details or styling as needed
        ],
      ),
    );
  }


  Widget _buildDefaultView(double fillRatio) {
    final Color fillColor =
        appTheme.cyan500; // Use a primary theme color for fill

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
                  decoration: BoxDecoration(
                      color: fillColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30.h)),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: Icon(widget.medication.icon,
                    size: 48.h, color: appTheme.cyan500),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          // DateFormat('HH:mm').format(widget.medication
                          //     .scheduledTimeList[DateTime.now().weekday]!), todo fix it
                          DateFormat('HH:mm').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 12.v, color: appTheme.grey100)),
                      Text(widget.medication.name,
                          style: CustomTextStyles.headlineSmallBold),
                      SizedBox(height: 4.v),
                      Text(
                          "1 ${widget.medication.type} \t ${widget.medication.betweenMeals}",
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
    return GestureDetector(
      onLongPress: () => setState(() {
        _isLongPressed = false;
        _isEditPressed = false;
      }),
      child: Container(
        key: ValueKey('longPressView'), // Unique key for AnimatedSwitcher
        padding: EdgeInsets.fromLTRB(12.h, 6.v, 13.h, 7.v),
        decoration: AppDecoration.white,
        child: Column(
          children: [
            // Pill name for verification
            Padding(
              padding: EdgeInsets.only(bottom: 8.v),
              // Add some space below the pill name
              child: Text(widget.medication.name,
                  style:
                      TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold)),
            ),
            // Scrollable row for actions
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // Center the icons in the row
                children: [
                  _buildIconButton(Icons.check_circle, "Take", Colors.green,
                      () {
                    Provider.of<AppState>(context, listen: false)
                        .deleteMedication(widget.medication);
                  }),
                  SizedBox(width: 16.h),
                  _buildIconButton(Icons.edit, "Edit", Colors.blue,
                      () => setState(() => _isEditPressed = true)),
                  SizedBox(width: 16.h),
                  _buildIconButton(Icons.info, "Info", Colors.amber,
                      () => setState(() => _isInfoPressed = true)),
                  SizedBox(width: 16.h),
                  _buildIconButton(Icons.delete, "Delete", Colors.red, () {
                    print('clicked delete');
                    print(widget.medication.runtimeType);
                    deleteMedicationFromBox(widget.medication.toMap());
                  }),
                ]),
          ],
        ),
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
                  child: Icon(widget.medication.icon,
                      size: 48.h, color: appTheme.cyan500),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormat('HH:mm').format(widget.medication
                                .scheduledTimeList[DateTime.now().weekday]!),
                            style:
                                TextStyle(fontSize: 12.v, color: Colors.grey)),
                        Text(widget.medication.name,
                            style: CustomTextStyles.headlineSmallBold),
                        SizedBox(height: 4.v),
                        Text(
                            "1 ${widget.medication.type} \t ${widget.medication.betweenMeals}",
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
              decoration: InputDecoration(
                  hintText: "Write notes about this treatment..."),
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

  Widget _buildInfoView() {
    return GestureDetector(
      onLongPress: () => setState(() {
        _isLongPressed = false;
        _isEditPressed = false;
        _isInfoPressed = false;
      }),
      child: Container(
        key: ValueKey('infoView'),
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Medication Information",
                  style:
                      TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              // Display the medication info. This is a placeholder. You should populate it with real data.
              Text("No information available for this medication.",
                  style: TextStyle(fontSize: 14.v)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon, String tooltip, Color color, VoidCallback onPressed) {
    return IconButton(
        icon: Icon(icon, size: 40.h),
        color: color,
        tooltip: tooltip,
        onPressed: onPressed);
  }
}
