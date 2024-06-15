// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:pillmate/core/app_export.dart';
// import 'package:pillmate/utils/notifications_scheduler.dart';
// import 'package:provider/provider.dart';
// import 'package:hive/hive.dart';
// import '../backend/app_state.dart';
// import '../services/medication.dart'; // Adjust the import paths as necessary.
// import 'package:flutter/foundation.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pillmate/theme/theme_helper.dart';
//
// TimeOfDay? findFirstNonNullTime(List<TimeOfDay?> times) {
//   for (var time in times) {
//     if (time != null) {
//       return time;
//     }
//   }
//   return null; // Return null if no non-null time is found
// }
//
// Future<String> searchMedication(String medName) async {
//   try {
//     // Reference to the medications collection
//     CollectionReference medications =
//     FirebaseFirestore.instance.collection('medications');
//
//     // Reference to the document with the given medication name
//     DocumentSnapshot docSnapshot = await medications.doc(medName).get();
//
//     // Check if the document exists
//     if (docSnapshot.exists) {
//       // Get the data from the document
//       Map<String, dynamic> data =
//       docSnapshot.data() as Map<String, dynamic>;
//
//       // Remove the 'brand_name' field from the data
//       data.remove('brand_name');
//
//       // Construct the medication data text
//       String medicationData = 'Medication data for $medName:\n\n';
//       data.forEach((key, value) {
//         // Check if the value is not null and not an empty list
//         if (!(value is List && value.isEmpty)) {
//           if (value is List) {
//             // Remove the first and last elements of the list if they are empty strings
//             if (value.first == '') value.removeAt(0);
//             if (value.last == '') value.removeLast();
//             // Format list values
//             String formattedValue = value.join('\n\n');
//
//             medicationData += '$key:\n$formattedValue\n\n';
//           }
//         }
//       });
//
//       // Return the formatted text
//       return medicationData;
//     } else {
//       return 'Medication not found: $medName';
//     }
//   } catch (error) {
//     // Handle error and return error message
//     return 'Internet connection could not be established.\nPlease verify your network settings and try again.\n'
//         'If the problem persists, please provide further details at pillmateSupport@gmail.com.';
//   }
// }
//
//
//
//
// IconData getIconForMedicationType(String type) {
//   print('Medication type: $type');
//   switch (type) {
//     case 'Pill':
//       return FontAwesomeIcons.pills;
//     case 'Drink':
//       return Ionicons.flask;
//     case 'Injection':
//       return FontAwesomeIcons.syringe;
//     case 'Powder':
//       return Icons.scatter_plot;
//     case 'Drops':
//       return Icons.water_drop;
//     case 'Other':
//       return Icons.medical_services;
//     default:
//       // Return a default icon in case the type is not found
//       return Icons.error_outline;
//   }
// }
//
// bool areMapsEqual(Map<String, dynamic> map1, Map<String, dynamic> map2) {
// // Compare the values of each key in the maps
//   for (var key in map1.keys) {
//     if (key == 'days') continue;
//     if (key == 'scheduledTimes') {
//       print('let us check');
//       List<dynamic>? scheduledTimeList1 =
//           map1['scheduledTimes'] as List<dynamic>?;
//       List<dynamic>? scheduledTimeList2 =
//           map2['scheduledTimeList'] as List<dynamic>?;
//       if (listEquals(scheduledTimeList1, scheduledTimeList2))
//         return true;
//       else {
//         print('${map1[key]} neq');
//         return false;
//       }
//     }
//     // Check if the values are lists and compare them using listEquals
//     if (map1[key] is List && map2[key] is List) {
//       if (!listEquals(map1[key], map2[key])) {
//         print('${map1[key]} neq ${map2[key]}');
//         return false;
//       }
//     } else {
//       // For non-list values, compare directly
//       if (map1[key] != map2[key]) {
//         print('${map1[key]} neq ${map2[key]}');
//         return false;
//       }
//     }
//   }
//
// // If all values are equal, return true
//   return true;
// }
//
// class MedListTile extends StatefulWidget {
//   final Medication medication;
//
//   const MedListTile({Key? key, required this.medication}) : super(key: key);
//
//   @override
//   _MedListTileState createState() => _MedListTileState();
// }
//
// class _MedListTileState extends State<MedListTile> {
//   bool _isLongPressed = false;
//   bool _isEditPressed = false;
//   bool _isInfoPressed = false;
//
//   Future<void> deleteMedicationFromBox(
//       Map<dynamic, dynamic> medicationData) async {
//     try {
//       final Box medicationsBox = await Hive.openBox('medications');
//
//       dynamic medicationKey;
//
//       for (var key in medicationsBox.keys) {
//         final storedData = medicationsBox.get(key);
//         if (storedData != null && storedData is Map<dynamic, dynamic>) {
//           print('$storedData');
//           final Map<String, dynamic> storedMap =
//               Map<String, dynamic>.from(storedData);
//           print('Data examined:${storedMap}');
//           final Map<String, dynamic> medicationDataMap =
//               medicationData as Map<String, dynamic>;
//           print('Data to be deleted: ${medicationDataMap}');
//           if (areMapsEqual(storedMap, medicationDataMap)) {
//             print('found');
//             medicationKey = key;
//             break; // Break the loop once the key is found
//           }
//         }
//       }
//
//       if (medicationKey != null) {
//         // Delete the medication from the box
//         print('medication key is: $medicationKey');
//         await medicationsBox.delete(medicationKey);
//
//         print('Medication deleted successfully!');
//       } else {
//         print('Medication not found in the box.');
//       }
//     } catch (e) {
//       print('Error deleting medication from Hive: $e');
//     }
//   }
//
//   double? calculateFillRatio(DateTime? scheduledTime) {
//     final DateTime now = DateTime.now();
//     if (scheduledTime == null) {
//       return null; // Medication is not scheduled for today.
//     }
//
//     DateTime adjustedScheduledTime = DateTime(
//         now.year, now.month, now.day, scheduledTime.hour, scheduledTime.minute);
//
//     // If the scheduled time is before now or more than 12 hours ahead, it's considered not scheduled for the current period.
//     if (adjustedScheduledTime.isBefore(now) ||
//         adjustedScheduledTime.isAfter(now.add(Duration(hours: 12)))) {
//       return null;
//     }
//
//     final DateTime startTime =
//         adjustedScheduledTime.subtract(Duration(hours: 12));
//     final double totalDuration =
//         adjustedScheduledTime.difference(startTime).inMinutes.toDouble();
//     final double elapsed = now.difference(startTime).inMinutes.toDouble();
//
//     return elapsed / totalDuration;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPress: () {
//         setState(() {
//           _isLongPressed = true;
//         });
//       },
//       child: AnimatedSwitcher(
//         duration: Duration(milliseconds: 300),
//         child: _isInfoPressed
//             ? _buildInfoView()
//             : _isEditPressed
//                 ? _buildExpandedView()
//                 : _isLongPressed
//                     ? _buildLongPressView()
//                     : _buildViewBasedOnSchedule(),
//       ),
//     );
//   }
//
//   DateTime? _findFirstScheduledTimeWithinNext12Hours() {
//     final DateTime now = DateTime.now();
//     for (var scheduledTime in widget.medication.scheduledTimeList) {
//       if (scheduledTime != null && scheduledTime.isAfter(now) && scheduledTime.isBefore(now.add(Duration(hours: 12)))) {
//         return scheduledTime;
//       }
//     }
//     return null;
//   }
//
//   double _calculateFillRatio(DateTime scheduledTime) {
//     final DateTime now = DateTime.now();
//     final Duration timeUntilScheduled = scheduledTime.difference(now);
//     final double totalDuration = Duration(hours: 12).inMinutes.toDouble();
//     final double timeUntilScheduledInMinutes = timeUntilScheduled.inMinutes.toDouble();
//     return (totalDuration - timeUntilScheduledInMinutes) / totalDuration;
//   }
//
//   Widget _buildViewBasedOnSchedule() {
//     // Find the first scheduled time within the next 12 hours
//     DateTime? nextScheduledTime = _findFirstScheduledTimeWithinNext12Hours();
//
//     if (nextScheduledTime == null) {
//       return Visibility(visible: false,child: SizedBox()); // If no scheduled time is found within the next 12 hours, return an empty widget
//     } else {
//       // Calculate the fill ratio based on the next scheduled time
//       double fillRatio = _calculateFillRatio(nextScheduledTime);
//       return _buildDefaultView(fillRatio, nextScheduledTime);
//     }
//   }
//
//   Widget _buildDefaultView(double fillRatio, DateTime scheduleTime) {
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
//                       color: appTheme.cyan500.withOpacity(0.5),
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
//                 child: Icon(getIconForMedicationType(widget.medication.type),
//                     size: 48.h, color: appTheme.cyan500),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 6.v),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(DateFormat('HH:mm').format(scheduleTime),
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
//
//   Widget _buildLongPressView() {
//     return GestureDetector(
//       onLongPress: () => setState(() {
//         _isLongPressed = false;
//         _isEditPressed = false;
//       }),
//       child: Container(
//         key: ValueKey('longPressView'), // Unique key for AnimatedSwitcher
//         padding: EdgeInsets.fromLTRB(12.h, 6.v, 13.h, 7.v),
//         decoration: AppDecoration.white,
//         child: Column(
//           children: [
//             // Pill name for verification
//             Padding(
//               padding: EdgeInsets.only(bottom: 8.v),
//               // Add some space below the pill name
//               child: Text(widget.medication.name,
//                   style:
//                       TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold)),
//             ),
//             // Scrollable row for actions
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 // Center the icons in the row
//                 children: [
//                   _buildIconButton(Icons.check_circle, "Take", Colors.green,
//                       () {
//                         NotificationUtils.cancelTodayMedicationNotifications(widget.medication);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Medication marked as taken!', style: TextStyle(color: appTheme.whiteA700)),
//                             backgroundColor: appTheme.teal500,
//                             behavior: SnackBarBehavior.floating,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                           ),
//                         );
//                       }),
//                   SizedBox(width: 16.h),
//                   _buildIconButton(LineIcons.medicalNotes, "Edit", Colors.blue,
//                       () => setState(() => _isEditPressed = true)),
//                   SizedBox(width: 16.h),
//                   _buildIconButton(Icons.info, "Info", Colors.amber, () {
//                     print('clicked info');
//                     searchMedication(widget.medication.name);
//                     _showMedicationInfoModal(context);
//                     // searchMedication(widget.medication.name);
//                   }),
//                   SizedBox(width: 16.h),
//                   _buildIconButton(Icons.delete, "Delete", Colors.red, () {
//                     print('clicked delete');
//                     print(widget.medication.runtimeType);
//                     deleteMedicationFromBox(widget.medication.toMap());
//                     NotificationUtils.cancelAllMedicationNotifications(widget.medication);
//                   }),
//                 ]),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildExpandedView() {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       key: ValueKey('expandedView'),
//       padding: EdgeInsets.all(12.h),
//       decoration: AppDecoration.white,
//       height: _isLongPressed ? 300.h : 100.h,
//       // Adjust height based on the state
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Existing row for medication details
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.h),
//                   child: Icon(widget.medication.icon,
//                       size: 48.h, color: appTheme.cyan500),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 6.v),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                             // DateFormat('HH:mm').format(widget.medication
//                             //     .scheduledTimeList[DateTime.now().weekday]!),
//                             DateFormat('HH:mm').format(DateTime.now()),
//                             style:
//                                 TextStyle(fontSize: 12.v, color: Colors.grey)),
//                         Text(widget.medication.name,
//                             style: CustomTextStyles.headlineSmallBold),
//                         SizedBox(height: 4.v),
//                         Text(
//                             "1 ${widget.medication.type} \t ${widget.medication.betweenMeals}",
//                             style: theme.textTheme.titleMedium),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.h),
//             // TextField for notes
//             TextField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                   hintText: "Write notes about this treatment..."),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     // Handle save logic here
//                     setState(() {
//                       _isEditPressed = false;
//                       _isLongPressed = false;
//                     });
//                   },
//                   child: Text('Save'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Optionally handle additional logic here
//                     setState(() {
//                       _isEditPressed = false;
//                       _isLongPressed = false;
//                     });
//                   },
//                   child: Text('Cancel'),
//                   // color: Colors.red,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoView() {
//     return GestureDetector(
//       onTap: () => _showMedicationInfoModal(context),
//       child: Container(
//         key: ValueKey('infoView'),
//         padding: EdgeInsets.all(12.h),
//         decoration: BoxDecoration(
//           color: appTheme.grey500,
//           borderRadius: BorderRadius.circular(20.h),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     "Medication Information",
//                     style: TextStyle(
//                       fontSize: 18.h,
//                       fontWeight: FontWeight.bold,
//                       color: appTheme.cyan500,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.close, size: 24.h, color: appTheme.grey500),
//                   onPressed: () => setState(() {
//                     _isInfoPressed = false;
//                   }),
//                 )
//               ],
//             ),
//             Text(
//               "Tap for more details",
//               style: TextStyle(fontSize: 14.h, color: appTheme.grey500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showMedicationInfoModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return _buildMedicationInfo(context); // Call an async function from within the builder
//       },
//     );
//   }
//
//   FutureBuilder _buildMedicationInfo(BuildContext context) {
//     return FutureBuilder<String>(
//       future: searchMedication(widget.medication.name),
//       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // While waiting for data, display a loading indicator
//           return Center(
//             child: CircularProgressIndicator(color: Colors.cyan),
//           );
//         } else {
//           // Once data is available, display it in the bottom sheet
//           return Container(
//             decoration: BoxDecoration(
//               color: appTheme.whiteA700,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20.h),
//                 topRight: Radius.circular(20.h),
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(16.h),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Detailed Medication Information",
//                       style: TextStyle(
//                         fontSize: 20.h,
//                         fontWeight: FontWeight.bold,
//                         color: appTheme.cyan500,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     // Display medication information received from the future
//                     Text(
//                       snapshot.data ?? 'No data available', // Handle null data
//                       style: TextStyle(fontSize: 14.h, color: appTheme.grey900),
//                     ),
//                     SizedBox(height: 20.h),
//                     ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: appTheme.cyan500,
//                         // primary: appTheme.cyan500, deprecation?
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.h),
//                         ),
//                       ),
//                       child: Text(
//                         'Close',
//                         style: TextStyle(color: appTheme.whiteA700),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//
//
//   Widget _buildIconButton(
//       IconData icon, String tooltip, Color color, VoidCallback onPressed) {
//     return IconButton(
//         icon: Icon(icon, size: 40.h),
//         color: color,
//         tooltip: tooltip,
//         onPressed: onPressed);
//   }
// }
